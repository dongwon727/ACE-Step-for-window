# train script by @bdsqlsz, edit by DFveloper

param (
    [int]$port = 7865,
    [int]$device_id = 0,
	[bool]$share = $False,
	[bool]$bf16 = $False,
	[bool]$torch_compile = $True,
	[bool]$cpu_offload = $True,
	[string]$checkpoint_path = "",
	[string]$server_name = "127.0.0.1",
	[bool]$overlapped_decode = $False
)

# Activate python venv
Set-Location $PSScriptRoot
if ($env:OS -ilike "*windows*") {
  if (Test-Path "./venv/Scripts/activate") {
    Write-Output "Windows venv"
    ./venv/Scripts/activate
  }
  elseif (Test-Path "./.venv/Scripts/activate") {
    Write-Output "Windows .venv"
    ./.venv/Scripts/activate
  }
}
elseif (Test-Path "./venv/bin/activate") {
  Write-Output "Linux venv"
  ./venv/bin/Activate.ps1
}
elseif (Test-Path "./.venv/bin/activate") {
  Write-Output "Linux .venv"
  ./.venv/bin/activate.ps1
}

$Env:HF_HOME = "huggingface"
$Env:TORCH_HOME= "torch"
#$Env:HF_ENDPOINT = "https://hf-mirror.com"
$Env:XFORMERS_FORCE_DISABLE_TRITON = "1"

python "./acestep/gui.py" --port $port --device_id $device_id --share $share --bf16 $bf16 --torch_compile $torch_compile --cpu_offload $cpu_offload

Read-Host | Out-Null ;
