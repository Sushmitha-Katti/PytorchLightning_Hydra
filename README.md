This template is from this [awesome]() repository. 

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
 
 

 

 



