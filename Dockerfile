FROM cptactionhank/atlassian-jira:latest
USER root:root
RUN chown -R daemon:daemon /var/atlassian/jira
USER daemon:daemon
