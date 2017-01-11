# Status Dashboard for MozMEAO

View the dashboard

[Stage](http://status.ramzom.org) | [Production](http://status.mozmar.org)

## Technology

### Worker

The worker is an [AWS Lambda](https://aws.amazon.com/lambda/) function which
gathers information about the services from different service providers. The
function is triggered every minute via ``CloudWatch Events`` and starts by
collecting the data. Then it compares the processed information against
`status.yml` located in the Git repository of each deployment
(e.g.
[prod](https://github.com/mozmar/status.mozmar.org/blob/master/status.yml)) and
if there are differences it commits them to the repository.

Currently data is collected from:

 * [NewRelic Synthetics](https://newrelic.com/synthetics)
 * [NewRelic APM](https://newrelic.com/application-monitoring)
 * [DeadMansSnitch](https://deadmanssnitch.com/)

Source code the website under [app](app/)

### Website

The website is a [React](https://facebook.github.io/react/) app served by GitHub
Pages. Every minute fetches status.yml and updates the page.

Source code the website under [local-dev](local-dev/)
