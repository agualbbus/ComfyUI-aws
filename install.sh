#!/bin/bash

# Install a separate conda installation via Miniconda
WORKING_DIR=/home/ec2-user/SageMaker
mkdir -p "$WORKING_DIR"
wget https://repo.anaconda.com/miniconda/Miniconda3-py310_23.5.2-0-Linux-x86_64.sh -O "$WORKING_DIR/miniconda.sh"
bash "$WORKING_DIR/miniconda.sh" -b -u -p "$WORKING_DIR/miniconda" 
rm -rf "$WORKING_DIR/miniconda.sh"

# Create a custom conda environment
source "$WORKING_DIR/miniconda/bin/activate"
KERNEL_NAME="comfyui"
PYTHON="3.10.6"
conda create --yes --name "$KERNEL_NAME" python="$PYTHON"
conda activate "$KERNEL_NAME"
pip install --quiet ipykernel

# Clone the repo and install dependencies
cd "$WORKING_DIR"
git clone https://github.com/comfyanonymous/ComfyUI
cd ComfyUI
pip install -r requirements.txt
pip install torch torchvision

#Install Ngrok
#export NGROK_TOKEN=your_token_here
pip install pyngrok
ngrok config add-authtoken "$NGROK_TOKEN"
cp /home/ec2-user/.ngrok2/ngrok.yml /home/ec2-user/SageMaker/ngrok.yml
