# train script by @bdsqlsz, edit by DFveloper

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

python "./acestep/gui.py" --port 7865 --device_id 0 --share false --bf16 false --torch_compile true --cpu_offload true

Read-Host | Out-Null ;
