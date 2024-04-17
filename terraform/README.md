## Steps for setting up Terraform

1. [Install Terraform locally](https://developer.hashicorp.com/terraform/install).

2. Navigate to the Terraform directory within the project folder:
   ```
   cd terraform
   ```

3. Set the `GOOGLE_CREDENTIALS` environment variable to point to your service account JSON key file. Run the following command in your terminal, replacing `path_to_my-creds.json` with the actual path to your JSON key file:
   ```
   export GOOGLE_CREDENTIALS="path_to_my-creds.json"
   ```

   Verify that the environment variable is set correctly by running:
   ```
   echo $GOOGLE_CREDENTIALS
   ```

4. Edit `variables.tf` with your project-specific information.

   *Note:* Make sure to use the same region for BigQuery, BigQuery dataset, and Google Cloud Storage bucket to avoid any region-related issues.

5. Initialize Terraform by running:
   ```
   terraform init
   ```

   This command downloads the necessary provider plugins and initializes Terraform in the current directory.

6. Preview the changes Terraform will make to your infrastructure by running:
   ```
   terraform plan
   ```

   This command generates an execution plan, showing you what actions Terraform will take based on your configuration files.

7. If the execution plan looks correct, apply the changes by running:
   ```
   terraform apply
   ```

8. Verify that the Google Cloud Storage bucket and BigQuery dataset have been created by checking the Google Cloud Console.

9.  (Optional) If you no longer need the deployed resources, you can destroy the infrastructure provisioned by Terraform. Run the following command:
    ```
    terraform destroy
    ```

    Exercise caution when running this command, as it will permanently delete the specified resources.