#!/usr/bin/env bash

# run in terminal with:
# ==> ./setup.sh

# if there are permission issues when running script try:
# ==> chmod +x setup.sh

echo "Renaming secret files and directories"

# Rename secret directories
mv ./dlt_data_load/dot-dlt ./dlt_data_load/.dlt

mv ./dbt_dlt_transformations/dot-dlt ./dbt_dlt_transformations/.dlt

# Rename secret files
mv ./terraform/pv-variables.tf ./terraform/variables.tf

mv ./dlt_data_load/.dlt/pv-config.toml ./dlt_data_load/.dlt/config.toml
mv ./dlt_data_load/.dlt/pv-secrets.toml ./dlt_data_load/.dlt/secrets.toml

mv ./dbt_dlt_transformations/.dlt/pv-config.toml ./dbt_dlt_transformations/.dlt/config.toml
mv ./dbt_dlt_transformations/.dlt/pv-secrets.toml ./dbt_dlt_transformationsd/.dlt/secrets.toml

EOL

echo "Renaming successful! Please, edit the contents of the files with your info"
echo "The secret files and directories have already been listed in gitignore"
