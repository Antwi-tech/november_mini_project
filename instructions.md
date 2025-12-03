# **Mini Project: Dockerize & Deploy a Python Application Using Jenkins CI/CD**

## **Repository**

Clone the project repository:

    git clone git@github.com:women-techsters-fellowship/november_mini_project.git

------------------------------------------------------------------------

## **Task Overview**

Each group will:

1.  **Create a branch** named after your group\
    Example:

        git checkout -b GROUP-A

2.  **Dockerize the Python application**

    -   Create or update the `Dockerfile`.
    -   Build a Docker image.
    -   Run and test the container **locally** to confirm the app works.

3.  **Create a `Jenkinsfile`** Your Jenkinsfile should define a **full
    CI/CD pipeline**:

    ### **CI Stage**

    -   Build the Docker image.
    -   Push the image to **Docker Hub** or another registry (ECR, GCR,
        etc.).

    ### **CD Stage**

    -   Connect to the AWS EC2 instance.
    -   Pull the newly pushed image.
    -   Run a container from that image on the EC2 instance.

------------------------------------------------------------------------

## **Tips**

1.  The provided Dockerfile in the project root **may already work**.\
    If not, install missing dependencies or use a full Python base image
    (e.g., `python:3.10-slim` or `python:3.10`).

2.  You **must create credentials** in Jenkins for:

    -   Docker Hub (or other registry)
    -   AWS account (for EC2/ECR)

3.  You may use **GitHub Actions** instead of Jenkins if you
    prefer---any working CI/CD approach is acceptable.

4.  **Do NOT** clone the repository directly on the EC2 instance and
    build it there.\
    You must deploy via CI/CD pulling from an image registry.

------------------------------------------------------------------------

## **Group Instructions**

-   You are to work **as a group**.
-   Each person may run the project individually for learning, but
    **submit only once per group**.
-   One person can volunteer to use their AWS account.\
    *This project should not generate any AWS charges.*
-   Create a `participants.txt` file and list **all contributors'
    names**.

------------------------------------------------------------------------

## **Deliverables**

Submit the following:

1.  **Screenshot of your Jenkinsfile**
2.  **Screenshot of your Jenkins Job console output**
3.  **Screenshot of the app running live**
4.  **The EC2 instance public IP address** and the **port** your app is
    mapped to

------------------------------------------------------------------------

## **Good luck! 🚀**

