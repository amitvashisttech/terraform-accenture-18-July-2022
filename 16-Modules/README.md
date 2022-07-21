# By Passing the default variables with Adhoc command line variables.  

```
terraform plan -var="frontend_instance_count=1"  -var="backend_instance_count=5"
terraform plan -var="frontend_instance_count=1"  -var="backend_instance_count=1"
```
