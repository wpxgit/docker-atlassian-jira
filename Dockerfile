FROM cptactionhank/atlassian-jira:latest
RUN chown -R daemon:daemon /var/atlassian/jira
