**Goal***

I want to create a Github Actions pipeline that can build and deploy multiple types of infrastucture. I am looking to build this pipeline in phases which will be specified below. Do not build any more than what is defined in each phase. 


### Phase 1
I want to create a "Hello World" GitHub action workflow that prints "Hello World" to the build console. I want to create this using standard and best practices for GitHub action pipelines. In an idiomatic way 

**Phase 1 status: complete**

### Phase 2
I want to create a Dockerfile that pulls in a hello world docker image. I would like to then update .github/workflows/hello-world.yml in order to build that image and deploy it to github image repository. Create two tags for the image v0.1 and latest. Image name hello-world-gh.

**Phase 1 status: Not started**