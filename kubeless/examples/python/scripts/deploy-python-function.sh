#!/bin/bash

# Bit overcomplicated way of deploying a python function for the 3.7 runtime
# with a handler named <base_file_name>.<function_name>. Execute with
#
# ./scripts/deploy-python-function.sh deep/nested/some_file.py some_function
#
# to deploy the function simple-function with handler some-file.simple_function
# or if the file and function are the same name, just with the first arg

full_file_path=$1
# Strip file path to get just the name of the file
base_file_name=`basename $full_file_path`
file_extension_removed=`echo -e $base_file_name | sed -e 's/\.py//'`
# Default file name to function name + .py, then make sure it's in kebab case
function=`echo -e ${2:-$file_extension_removed} | sed -e 's/_/-/'`
handler="$function.$file_extension_removed"

echo "Deploying function $function in file $PWD/$full_file_path with handler $handler"

kubeless function deploy $function \
  --runtime python3.7 \
  --from-file $PWD/$full_file_path \
  --handler=$handler

# Display deployed functions
echo "Success! Deployed functions:"
kubectl get functions
