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
make build #using makefile, using the image name as cifar10

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
   - Implementation is simialr to MNIST. Changed the reference of MNIST to CIFAR10

2. New model(cidar10_module) is added [here](https://github.com/Sushmitha-Katti/PytorchLightning_Hydra/blob/main/src/models/cifar10_module.py) in module.
   - Similar Implemetation as MNIST. But removed net parameter from init and added model name parameter to dynamically take timm pretrained model as input.
   
   ```python
   def __init__(
        self,
        model_name: 'resnet34',  #----------------NEW CHANGE ------------
        optimizer: torch.optim.Optimizer,
    ):
        super().__init__()

        # this line allows to access init params with 'self.hparams' attribute
        # also ensures init params will be stored in ckpt
        self.save_hyperparameters(logger=False, ignore=["net"])

        #------------------- THIS IS NEW CHANGE -------------------
        self.net = timm.create_model(model_name, pretrained = True)
        #----------------------------------------------------------

        # loss function
        self.criterion = torch.nn.CrossEntropyLoss()

        # metric objects for calculating and averaging accuracy across batches
        self.train_acc = Accuracy()
        self.val_acc = Accuracy()
        self.test_acc = Accuracy()

        # for averaging loss across batches
        self.train_loss = MeanMetric()
        self.val_loss = MeanMetric()
        self.test_loss = MeanMetric()

        # for tracking best so far validation accuracy
        self.val_acc_best = MaxMetric()
   
   ```
   

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








 

 

 



