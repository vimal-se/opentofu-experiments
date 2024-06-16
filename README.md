This is an Infrastructure as a service (IaaS) repo written in OpenToFu.
Each folders will have different IaaS codes.

**Step 1 : Install OpenToFu**

Please follow the steps in https://opentofu.org/docs/intro/install/

**Step 2 : Set AWS Environment Variables**

Please follow the steps in https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-envvars.html#envvars-set

**Step 3 : Clone the repo**

`git clone git@github.com:vimal-se/opentofu-experiments.git`


**Step 4 : Build your repo from each folders**
goto (cd into) your required folder and execute the following
```
tofu init
tofu plan
tofu apply
```

