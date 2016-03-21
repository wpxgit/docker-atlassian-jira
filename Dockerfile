FROM cptactionhank/atlassian-jira:latest
RUN chown -R daemon:daemon /var/atlassiant/jira
