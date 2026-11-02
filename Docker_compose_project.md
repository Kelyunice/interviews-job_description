
Docker Compose Practice — Complete DevOps Study Notes
Project guide · Commands · Achievements · Troubleshooting · Rollback
1. Our project plan
Project: docker-compose-practice
GitHub repository: Kelyunice/docker-compose-practice
Docker Hub repository: kelyunice1419/docker-compose-app
Our goal
Build a multi-container application, make its services communicate, test it, and automate the process of checking and publishing Docker images through GitHub Actions.

Phase 1 — Build the application
Node.js application, Dockerfile, and version 2.0.




Phase 2 — Connect the services
Docker Compose, Redis, and Nginx reverse proxy.




Phase 3 — Test the deployment
Check containers, application responses, ports, and logs.




Phase 4 — Manage the project with Git
Track changes, commit code, and push to GitHub.




Phase 5 — Automate with GitHub Actions
Validate Compose, build the image, run a smoke test, and publish to Docker Hub.




Phase 6 — Understand rollback
Restore a known-good image manually; learn what remains to implement for automated rollback.



2. Project architecture
Our application has three main services.
Browser
Access through localhost:3003

Nginx reverse proxy
Host port 3003 → container port 80

Node.js application
Host port 3002 → container port 3000

Redis
Container port 6379; not published to the host in our setup

Conceptual view of the services. Redis is a separate service; this diagram does not mean every request must pass through Redis.

The application displayed:
Making Progress In DevOps Skills -Version 2.0
It also displayed a visit count and an environment value.
What Docker Compose taught us: instead of manually starting each container and managing its connections individually, we describe the services in a Compose configuration and operate them together.

3. Phase 1 — Prepare the project
Our working directory was:
cd ~/devops-practice/docker-compose-practice


To confirm where we are and inspect the project:
pwd
ls -la


Useful project files included:
- Dockerfile — instructions for building the Node.js image.
- compose.yaml or docker-compose.yml — service configuration; use whichever filename is actually in your repository.
- nginx/default.conf — Nginx reverse proxy configuration.
- package.json — Node.js project information.
- .github/workflows/ci.yml — GitHub Actions automation.
To inspect files:
ls -la
ls -la .github/workflows


Achievement: We had a project directory containing the application, container configuration, and automation workflow.
4. Phase 2 — Build the application image
The application image was versioned as 2.0.
A Docker image is the packaged application template. A container is a running instance created from an image.
The build command used in our GitHub Actions workflow was equivalent to:
docker build -t kelyunice1419/docker-compose-app:2.0 .


To see available local images:
docker images


Important parts of the build command:
Part	Meaning
docker build	Build an image from a Dockerfile
-t	Assign a name and tag
kelyunice1419/docker-compose-app	Image repository
:2.0	Version tag
.	Use the current directory as the build context
Achievement: We prepared a versioned Docker image that could be run locally and published to Docker Hub.
5. Phase 3 — Configure and start the services
We used Docker Compose to coordinate the Node.js app, Redis, and Nginx.
Validate the Compose configuration
docker compose config --quiet


This checks whether Compose can parse and resolve the configuration. If the command exits without an error, that is a good sign, although it does not prove the application itself works.
Start the services
For local development, the command we used was:
docker compose up -d --build


- up creates and starts the services.
- -d runs them in the background.
- --build rebuilds images where the configuration specifies a build.
Inspect the services
docker compose ps


For all containers on the machine, including stopped ones:
docker ps -a


Achievement: We practiced bringing up a multi-container application as one stack instead of managing each service separately.
6. Phase 4 — Test the running application
Our important access points were:
URL	Purpose
http://localhost:3003	Application through Nginx
http://localhost:3002	Direct access to the Node.js app, if its published port is available
Check the main application:
curl http://localhost:3003


Check the Node.js service directly:
curl http://localhost:3002


The first URL checks the request path through Nginx. The second can help isolate whether the application responds independently of the reverse proxy.
If a request fails, do not immediately rebuild everything. Inspect the services first:
docker compose ps
docker compose logs


For service-specific logs:
docker compose logs app
docker compose logs nginx


Use the service names shown in your actual Compose configuration if they differ.
Achievement: We verified the application response and learned to troubleshoot the stack by inspecting status, connectivity, and logs.
7. Phase 5 — Use Git to track our changes
Before committing changes, we checked the repository state:
git status
git diff
git diff --check


Then we staged, committed, and pushed the changes:
git add .
git commit -m "Test deployment before publishing Docker image"
git push origin main


One of our recorded commits was:
f4472e3 Test deployment before publishing Docker image


Another was:
dcb0b94 Update GitHub Actions for Node.js 24


To review the history:
git log --oneline


Achievement: Our project changes were tracked in Git and pushed to the main branch on GitHub. This allowed GitHub Actions to run when we pushed updates.

8. Phase 6 — Build the CI/CD workflow
This was one of our most important DevOps achievements.
Our workflow file was:
.github/workflows/ci.yml


The workflow was named docker-compose-practice and used a GitHub-hosted Ubuntu runner:
name: docker-compose-practice

on:
  push:
    branches:
      - main


What does the runner do?
Think of GitHub Actions as the office that organizes a task. The runner is the computer that carries out the task.
Our workflow used:
runs-on: ubuntu-latest


GitHub provided a hosted Ubuntu environment to execute the workflow. It checked out our repository, ran Docker commands, tested the application, and published the image. We did not need to leave our own laptop running for the hosted job to execute.
What our workflow did, in order
1. Check out the repository. The runner downloads the project files for the job using actions/checkout@v5.
2. Validate Docker Compose. It runs docker compose config --quiet to check the configuration.
3. Build the application image. It builds version 2.0 and a second tag containing the full Git commit SHA.
4. Start a temporary test deployment. It starts the Compose services on the runner, not on a production server.
5. Run the smoke test. It requests http://localhost:3003 and checks for the expected Version 2.0 text.
6. Clean up the temporary stack. The cleanup step uses if: always() so it runs even when an earlier test step fails.
7. Log in to Docker Hub. It uses GitHub repository secrets for the credentials.
8. Publish the tested image. The image is pushed to Docker Hub only if the preceding required steps succeed.
How the workflow checks the application
The central check was similar to:
curl --fail --silent http://localhost:3003 \
  | grep -q "Making Progress In DevOps Skills -Version 2.0"


The workflow retries the request while the application starts. If it cannot find the expected text within the retry window, the test fails.
This is a smoke test: a basic check that the application starts and responds as expected. It is not a comprehensive test of every application feature.
Why we did not rely on npm test
Our package.json contained a placeholder test script that deliberately exits with an error because no test was configured. We therefore used the HTTP smoke test in the workflow instead. We should not claim that a full application unit-test suite passed.
The Docker Hub tags
Our workflow built two tags:
docker build \
  -t kelyunice1419/docker-compose-app:2.0 \
  -t kelyunice1419/docker-compose-app:${GITHUB_SHA} \
  .


The actual GitHub Actions workflow used ${{ github.sha }} to supply the full commit SHA. The ${GITHUB_SHA} above is just a shell-style illustration of the same idea.
- 2.0 is a human-readable version tag.
- The commit SHA tag identifies the specific source revision used to build that image.
Achievement: The workflow completed successfully, and the 2.0 and commit-SHA tags appeared in Docker Hub. We confirmed a successful run and resolved the earlier authentication issue.

9. Problems we encountered and how we solved them
Problem A — Docker Hub login failed
We encountered an error similar to:
unauthorized: incorrect username or password


Cause: The credentials supplied to the GitHub Actions login step were not accepted.
What we did:
1. Removed the old repository secrets.
2. Set DOCKERHUB_USERNAME to kelyunice1419.
3. Created a new Docker Hub access token with Read & Write permission.
4. Saved the token as DOCKERHUB_TOKEN in the GitHub repository secrets.
5. Reran the workflow and confirmed that publishing succeeded.
The secrets belong in the repository's Settings → Secrets and variables → Actions. Never put the actual token in your source code or paste it into public logs.
Problem B — Node.js 20 deprecation warning
We updated the workflow actions to:
uses: actions/checkout@v5


and:
uses: docker/login-action@v4


After pushing the changes, we confirmed the workflow succeeded without the earlier Node.js 20 deprecation warning.
Problem C — Ubuntu runner migration notice
We saw a notice about ubuntu-latest moving to Ubuntu 26 beginning October 19, 2026.
That notice was not the same as a failed job. We kept ubuntu-latest for the time being rather than changing the runner without a reason.
Troubleshooting command reference
Use these commands when you return to the project:
Command	Why you use it
pwd	Confirm the current directory
git status	See uncommitted changes
docker compose config --quiet	Validate the Compose configuration
docker compose ps	Inspect services in the Compose project
docker ps -a	Inspect all containers, including stopped ones
docker compose logs	Read logs from the stack
docker compose logs app	Read the app service logs
docker compose logs nginx	Read the Nginx service logs
curl http://localhost:3003	Check the application through Nginx
docker images	Inspect local images and tags
git log --oneline	Review recent commits

10. Manual rollback — returning to a known-good image
A rollback means returning to an earlier version after a newer version has a problem.
Important: Docker Hub retaining an older tag does not automatically roll back a running application. Someone or something must instruct the deployment to use that older image.
For this Compose project, the following is a manual rollback procedure to use if version 1.0 is still available in Docker Hub and your Compose configuration uses the APP_IMAGE variable for the app image.
Step 1 — Check your current stack
From the project directory:
docker compose ps


Step 2 — Pull the known-good image
docker pull kelyunice1419/docker-compose-app:1.0


This downloads the old image, if that tag exists in your Docker Hub repository.
Step 3 — Recreate the Compose app using version 1.0
First, confirm the actual Compose service name for the Node.js app and that its image field uses the APP_IMAGE variable, as in our project configuration.
Then run:
APP_IMAGE=kelyunice1419/docker-compose-app:1.0 \
docker compose up -d --no-build


This passes APP_IMAGE to that Compose command. Compose uses the known-good tag for the service whose image is configured with that variable. Other services, such as Redis and Nginx, are still managed by Compose.
If your Compose file does not use that variable for the app image, stop here and inspect the configuration before attempting the rollback.
Step 4 — Verify the result
docker compose ps
docker compose logs app
curl http://localhost:3003


Check that the application responds and displays the expected older version. If version 1.0 does not exist or does not start correctly, do not assume the rollback succeeded.
What this demonstrates: you can select a previously published image and manually ask Compose to use it. It does not prove an automated rollback mechanism exists.

11. Automated rollback — what is and isn't completed
There are two different kinds of automation in this project.
Completed: automated testing before publishing
GitHub Actions validates the Compose configuration, builds the image, starts a temporary stack, checks the response, cleans up, and publishes the image only if the preceding steps succeed.



Not yet implemented: automated live-deployment rollback
We have not verified a workflow that deploys a new version to a persistent production environment, detects a failed deployment there, and automatically restores the previous version.



To build true automated rollback, we would need a deployment target, a record of the known-good version, a health check against the deployed application, and a workflow step that redeploys the previous version if the new deployment fails.
We have not yet implemented or tested that complete process in docker-compose-practice. It is a future exercise, not a completed achievement.

12. Clean up and manage the stack safely
To stop the Compose services and remove their containers and networks:
docker compose down


To see whether containers remain:
docker ps -a


Our CI workflow used this cleanup command for its temporary test deployment:
docker compose down --volumes --remove-orphans


Be careful with --volumes: it removes Compose-managed volumes and can delete stored data in those volumes. Only use it when you intend to remove that data, such as when cleaning up a disposable test environment.
To start the local stack again:
docker compose up -d


To rebuild the app image as well:
docker compose up -d --build


13. Final project achievements
By completing this project, you practiced the following real DevOps skills:
- Building and tagging a Docker image.
- Coordinating Node.js, Redis, and Nginx with Docker Compose.
- Understanding host ports versus container ports.
- Checking service health through curl, container status, and logs.
- Tracking project changes with Git and pushing to GitHub.
- Using a GitHub-hosted Actions runner.
- Validating configuration and testing an application before publishing an image.
- Publishing version and commit-SHA tags to Docker Hub.
- Managing GitHub Actions secrets securely.
- Understanding manual rollback and what is still required for automated rollback.
Your strongest accurate project statement is:
I containerized a Node.js application, orchestrated its services using Docker Compose, and built a GitHub Actions CI/CD workflow that validates the configuration, runs a smoke test, and publishes versioned Docker images to Docker Hub.

===================================================================================================================================================================
                           ===========General Best Practice of Writting Dockerfile========================
1. Use Multi-stage builds:
   Multi-stage builds let you reduce the size of your final image, by creating a cleaner separation between the building of your image and the final output

2. Exclude with .dockerignore: files which are not relevant to the build

3. Create ephemeral containers: meaning the container can be stopped and destroyed and then rebuilt and replaced with an absolute minimum set up and configuration

4. Don't install unnecessary packages

5. Decouple application: Decoupling applications into multiple containers makes it easier to scale horizontally and reuse containers

6. Sort Multi-line arguments: Whenever possible, sort multi-line arguments to make maintenance easier

7. Leverage build cache: When building an image, Docker steps through the instructions in your Dockerfile, executing each in the order specified.  For each instruction, Docker checks whether it can reuse the instruction from the build cache.

8. Pin base image version: using image tag






