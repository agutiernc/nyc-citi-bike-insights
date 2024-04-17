## Steps for setting up Terraform

1. [Install Terraform locally](https://developer.hashicorp.com/terraform/install).

2. Open your terminal and navigate to the Terraform directory within the project folder:
   ```
   cd terraform
   ```

3. Ensure that you have set up Google Cloud authentication credentials for Terraform to interact with your GCS account. By default, Terraform looks for the `GOOGLE_CREDENTIALS` environment variable.

4. Set the `GOOGLE_CREDENTIALS` environment variable to point to your service account JSON key file. Run the following command in your terminal, replacing `path_to_my-creds.json` with the actual path to your JSON key file:
   ```
   export GOOGLE_CREDENTIALS='path_to_my-creds.json'
   ```

   You can verify that the environment variable is set correctly by running:
   ```
   echo $GOOGLE_CREDENTIALS
   ```

5. Open the `variables.tf` file in the Terraform directory and edit the variables with your project-specific information.

   <span style="color:yellow">Note:</span> Make sure to use the same region for BigQuery, BigQuery dataset, and Google Cloud Storage bucket to avoid any region-related issues.

6. Initialize Terraform by running:
   ```
   terraform init
   ```

   This command downloads the necessary provider plugins and initializes Terraform in the current directory.

7. Preview the changes Terraform will make to your infrastructure by running:
   ```
   terraform plan
   ```

   This command generates an execution plan, showing you what actions Terraform will take based on your configuration files.

8. If the execution plan looks correct, apply the changes by running:
   ```
   terraform apply
   ```

   Terraform will prompt you to confirm the changes. Enter "yes" to proceed.

9. After the `terraform apply` command finishes successfully, verify that the Google Cloud Storage bucket and BigQuery dataset have been created by checking the Google Cloud Console.

10. (Optional) If you no longer need the deployed resources, you can destroy the infrastructure provisioned by Terraform. Run the following command:
    ```
    terraform destroy
    ```

    Exercise caution when running this command, as it will permanently delete the specified resources. Terraform will prompt you to confirm the destruction. Enter "yes" to proceed.

With these steps completed, you have successfully set up Terraform and provisioned the necessary Google Cloud resources for the project. You can now move on to the next steps of the project navigate and also navigate back to the main project folder.