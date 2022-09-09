This template is from this [awesome](https://github.com/ashleve/lightning-hydra-template) repository. 

### Changes made to the template

1. Added CIFAR10 datamodule
2. Provided a CIFAR10 training
3. Integrated timm models in training.
4. Included docker build
5. Makefile has a command to build docker

### How to Run

1. Build docker image

```bash
make build #using makefile

```

2. Train Model Using docker

```bash
docker run cifar10:latest src/train.py experiment=example
```

3. Evaluate Image

```bash
docker run cifar10:latest src/eval.py
```

4. To change model
 - If you are giving experiment file: change the name in model_name
 - By default it will be : model/cifar10.yml - model_name
 

## Assignement Implementation

1. New data module(cifar10_datamodule) is added [here](https://github.com/Sushmitha-Katti/PytorchLightning_Hydra/blob/main/src/datamodules/cifar10_datamodule.py) in datamodule

2. New model(cidar10_module) is added [here](https://github.com/Sushmitha-Katti/PytorchLightning_Hydra/blob/main/src/models/cifar10_module.py) in module.

3. cifar10 config datamodule added [here](https://github.com/Sushmitha-Katti/PytorchLightning_Hydra/tree/main/configs/datamodule)

4. New model cifar10 is added [here](https://github.com/Sushmitha-Katti/PytorchLightning_Hydra/blob/main/configs/model/cifar10.yaml) in model configs with the integration of timm. net paramert was removed and model_name parameter was introduced to dynamically give timm supported model name. 

5. In experiment example.yml removed net paramter and added model_name parameter [here](https://github.com/Sushmitha-Katti/PytorchLightning_Hydra/blob/main/configs/experiment/example.yaml)

6. In [train.yml](https://github.com/Sushmitha-Katti/PytorchLightning_Hydra/blob/main/configs/train.yaml) and [eval.yml](https://github.com/Sushmitha-Katti/PytorchLightning_Hydra/blob/main/configs/eval.yaml) changed the references from mnist to cifar

7. Added timm in [requirements.txt](https://github.com/Sushmitha-Katti/PytorchLightning_Hydra/blob/main/requirements.txt)

8. Added [Dockerfile](https://github.com/Sushmitha-Katti/PytorchLightning_Hydra/blob/main/Dockerfile) with the below content

 ```docker
 FROM python:3.8-slim

 WORKDIR /opt/src

 COPY requirements.txt requirements.txt

 RUN pip3 install --no-cache-dir --user -r requirements.txt

 COPY . .
 ```
 9. Added docker build command in [makefile](https://github.com/Sushmitha-Katti/PytorchLightning_Hydra/blob/main/Makefile)
 
  ```yml
  build:
       docker build -t cifar10 .
  ```








 

 

 



