class ChangeStringsToNumbers < ActiveRecord::Migration
  def change
  execute %q{
    alter table git_hub_issues
    alter column gitHubID
    type int using cast(gitHubID as int)
  }
  execute %q{
    alter table git_hub_issues
    alter column number
    type int using cast(number as int)
  }
  end
end
