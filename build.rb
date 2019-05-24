#!/usr/bin/env ruby
require 'erb'
require 'pry'
require 'active_support/core_ext/string'

@create_table_template = File.read('build.html.erb')
@create_table_renderer = ERB.new(@create_table_template, nil, '-')

projects = {
  'thirdchannel' => {
    staging: 'https://www.staging.thirdchannel-staging.com/',
    prod: 'https://www.thirdchannel.com/',
  },
  'rabbitmq' => {
    staging: 'https://rabbitmq.staging.thirdchannel-staging.com/#/',
    prod: 'https://strong-emu.rmq.cloudamqp.com/#/',
  },
  'job-scheduling' => {
    repo: 'https://github.com/thirdchannel/job-scheduling',
    ebs: 'https://us-east-1.console.aws.amazon.com/elasticbeanstalk/home?region=us-east-1#/environment/dashboard?applicationName=Procrastination&environmentId=e-2anm42qmsm',
    builds: 'https://jenkins.thirdchannel.com/blue/organizations/jenkins/ThirdChannel%2Fjob-scheduling/branches',
    deploy: 'https://jenkins.thirdchannel.com/blue/organizations/jenkins/production%2Fjob-scheduling%2Fdeployment/branches',
  },
  'ingest-aggregation' => {
    repo: 'https://github.com/thirdchannel/ingest-aggregation',
    ebs: 'https://console.aws.amazon.com/elasticbeanstalk/home?region=us-east-1#/environment/dashboard?applicationName=ingest-aggregation&environmentId=e-bfim4zkirc',
    builds: 'https://jenkins.thirdchannel.com/blue/organizations/jenkins/ThirdChannel%2Fingest-aggregation/branches',
    deploy: 'https://jenkins.thirdchannel.com/blue/organizations/jenkins/production%2Fingest-aggregation%2Fdeployment/branches',
  },
  'thirdchannel-legacy' => {
    repo: 'https://github.com/thirdchannel/thirdchannel-legacy',
    builds: 'https://jenkins.thirdchannel.com/blue/organizations/jenkins/ThirdChannel%2Fthirdchannel-legacy/branches',
    deploy: 'http://build.thirdchannel.com/jenkins/view/ThirdChannel/job/ThirdChannel-production-deploy/',
  },
  'jira' => {
    'program services queue' => 'https://thirdchannel.atlassian.net/issues/?filter=20599',
    'current sprint' => 'https://thirdchannel.atlassian.net/issues/?filter=14300',
    'create ticket' => 'https://thirdchannel.atlassian.net/secure/CreateIssue!default.jspa',
  }

}

file_name = "index.html"
File.open(file_name, 'w') do |file|
    b = binding
    b.local_variable_set(:projects, projects)
    create_table_body = @create_table_renderer.result(b)
    file.write(create_table_body)
end
