# Automating Infrastructure building using terraform and aws developer tools

## Step:1 Initializing a git repository in local machine

## Step:2 Creating a repository in github.

## step:3 Creating files in local repository that defines infra.

Create a **main.tf** file which defines the required infrastructure to be build.
In my case I am building an EC2 instance with latest version of amazon linux in a private subnet and attaching security group which I am going to create in further steps.
Create **build-spec.yml** file which defines installing terraform and execute its commands.
This will destroy the previous build and create the new Infra.
I recommend to change it according to your requirement.
Create a **backend.tf** file which defined what storage is used to store the current terraform state.

## Step:4 Create a AWS S3 bucket using your account.

Make sure you give the bucket name unique and same name mentioned in **backend.tf** file and also make sure you enabled bucket versioning.

## Step:5 Create a AWS VPC and a new security group in it.

Create it as per you requirement I created private and public subnets in 2 Availability zones each having around 4000 IP ranges.

## Step:6 Create an IAM role.
Its considered to most crucial and should be done with atmost care.
Attach EC2 access, S3 access, IAM access, cloudwatchevents access policies to the role and create an inline policy like below.
![alt text](images/Inline_policy.png)

## Step:7 Create a connection to your Github repo from aws developer tools.

Navigate to aws developer tools --> Setting --> Connections
Create a connection to your github repo by providing required authentication.
Make sure aws connector for github app has pemissions to access required repositories.

## Step:8 Create a code pipeline.

First Create a code build project by giving the connection you created as source.
Create the new OAuth app token connection by giving required credential that stores the credentials in KMS that are used to access the repo.
Choose the environment correctly
Specify then build-spec.yml correctly as in the repo.
Attach the ARN of IAM role you created previously with required permissions.

Now create the pipline with the github repo as source and webhook the main branch for ever push.
choose the created build project in the build stage.

## Step:9 Push the code from local repo to the main branch of github repo.

As you push the code the pipeline gets triggered and starts the build.
It build using the enviroment you specified and instructions given in yml file.
The terraform applies the main.tf Infra and build the Infrstructure in our VPC.
You might get a doubt how the terraform know where i.e in which VPC to create the infra?
Since you had already attached the service role, it automatically knows who (aws account) is initiating the request and resouces created by him. 
We also had given subnet and security group details, hence it knows in which VPC to create the required resources.
If no details are given it creates in default VPC.

