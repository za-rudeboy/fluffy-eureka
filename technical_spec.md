**Goal***

I want to create a Github Actions pipeline that can build and deploy multiple types of infrastucture. I am looking to build this pipeline in phases which will be specified below. Do not build any more than what is defined in each phase. 


### Phase 1
I want to create a "Hello World" GitHub action workflow that prints "Hello World" to the build console. I want to create this using standard and best practices for GitHub action pipelines. In an idiomatic way 

**Phase 1 status: complete**

### Phase 2
I want to create a Dockerfile that pulls in a hello world docker image. I would like to then update .github/workflows/hello-world.yml in order to build that image and deploy it to github image repository. Create two tags for the image v0.1 and latest. Image name hello-world-gh.

**Phase 2 status: complete**

### Phase 3
I want to deploy the hello-world-gh Docker image to Azure Container Apps using GitHub Actions and Bicep for infrastructure as code. The deployment should create the necessary Azure resources (Resource Group, Container App Environment, Container App) and deploy the image from GitHub Container Registry to Azure Container Apps.
I want to use .bicep for infrastructure in Azure. I want it in a directory called infrastructure.

3.1 Create Resource Group, if it does not already exist **3.1 is complete**
3.2 Create Container App Managed Environment. Add this to file called container-compute.bicep **3.2 is complete**
3.3 Create hello-world container app within that managed environment from 3.2. Add this to file called container-compute.bicep **3.3  is complete**

**Phase 3 status: is complete**

### Phase 4
I want to create a .Net Aspire application. I want this application to be containerised and deployed to the container app defined in @.github/workflows/hello-world.yml. In other words I want to replace the existing hello-world container with this new .net Aspire application. Therefore update @Dockerfile and update @hello-world.yml. I would like the image name and tag to be dotnet-aspire:v0.1. 

