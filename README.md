# NodeNotifier
This project provides an automated monitoring and notification system for computing clusters managed by SLURM. It is designed to track node health and automatically send email alerts when nodes go down, ensuring timely awareness for system administrators. 

🚀 Features

*   Monitors SLURM-managed compute nodes.
*   Automatically detects and reports downed nodes.
*   Sends structured email notifications to designated recipients.
*   Implemented entirely with Bash scripts and SLURM utilities (scontrol, sinfo).
*   Lightweight and easy to integrate into existing HPC environments.

**Note**: This project was developed as part of my academic work and is currently a prototype. Some features (such as full error handling, logging, and extended test coverage) were left incomplete as I graduated before final deployment. The repository documents my approach, design decisions, and the working parts of the system.

**Future Work**
*  Add logging and monitoring dashboard integration.
*  Expand testing framework with mock node failures.
*  Improve error handling for false positives.
