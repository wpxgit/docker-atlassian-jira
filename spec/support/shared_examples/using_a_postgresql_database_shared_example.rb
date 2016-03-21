require 'timeout'
require 'spec_helper'

shared_examples 'using a postgresql database' do
	before :all do
		within 'form#jira-setup-database' do
			# select using external database
			choose 'jira-setup-database-field-database-external'
			# allow some time for the DOM to change
			sleep 1
			# fill in database configuration
			select "PostgreSQL", :from => 'jira-setup-database-field-database-type'
			fill_in 'jdbcHostname', with: @container_db.host
			fill_in 'jdbcPort', with: '5432'
			fill_in 'jdbcDatabase', with: 'jiradb'
			fill_in 'jdbcUsername', with: 'postgres'
			fill_in 'jdbcPassword', with: 'mysecretpassword'
			# continue database setup
			click_button 'Next'
		end
  end
end
