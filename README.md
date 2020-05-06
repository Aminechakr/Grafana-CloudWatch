# Grafana-CloudWatch

## This is a quick readme tutorial of how to connect an ec2 grafana with cloudwatch : 

#### 3 ways to do that : with ARN assumed Role, Credentials file or Access Key and Secret Key ( the last option is not really recommended since it a little bit unsafe )


- Frist create a policy in IAM :
    > Go to IAM Service policies > create policies > choose cloudwatch as a service > then choose in Access level ListMetrics
and also choose in Read GetMetricData & GetMetricStatistics > then review and give a name "Grafana policy" to the policy and create it after.

- Secondly create a Role in IAM : 
    > Go to IAM service > Roles > create a role > AWS Service > EC2 > next permissions > filter policies and search for Grafana Policy > give it a name `"Grafana Role"` and then create the role.

- Thirdly create a user : 
    > **Note**  : for this option you do it only if you have a Grafana under an EC2 instance ) if your grafana is deployed in a pod in Kubernetes we suggest to opt for a Kube2iam or Kiam solution to assume the role for the pod and further the ARN Solution wich is not covered in this tutorial. 
  
    >Let's create the user if we are under the EC2, go to IAM services > users > create a user > name: Grafana user and programatic access > next permissions > attach existing policy wich is `"Grafana policy"`.

- Next is attaching the policy to the EC2 instances:
   > Go to EC2 in aws ressources > look out for your Grafana EC2 instance > and then instances settings > attach IAM Role > attache the `"Grafana Role"`.

- Then go to your Grafana UI to add the Data Sources:

```bash 
    - Name : Aws CloudWatch
    - Type : Cloudwatch 
    - Auth Provider : ARN or Credentials file (depending on the solution the solution option that you are setting )
    - Default Region : Region name 
``` 

**for troubleshoot issues log file under /var/log/grafana/grafana.log**

- Finally we set our Dashboard: 
    > Go to **`+`** in Grafana to create dashboard and click create dashboard > select **graph** > in parnel title select `Edit` >  Go to `Metris` choose `Region` slect the service that you need to monitor > and the indicator that you need to monitor.
    > Then go to `Dimensions` choose a tag of your instance ressource and his `ID` to get it in a graph > and save it.