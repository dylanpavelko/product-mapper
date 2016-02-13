# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160213194703) do

  create_table "asana_auth_end_points", force: true do |t|
    t.integer  "user_id"
    t.string   "auth_code"
    t.string   "bearer_token"
    t.datetime "token_date"
    t.string   "refresh_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "asana_auth_end_points", ["user_id"], name: "index_asana_auth_end_points_on_user_id"

  create_table "asana_tasks", force: true do |t|
    t.string   "name"
    t.string   "asana_id"
    t.integer  "asana_workspace_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  add_index "asana_tasks", ["asana_workspace_id"], name: "index_asana_tasks_on_asana_workspace_id"

  create_table "asana_workspaces", force: true do |t|
    t.string   "workspace"
    t.integer  "node_id"
    t.integer  "added_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "auth_endpoint_id"
  end

  add_index "asana_workspaces", ["added_by_id"], name: "index_asana_workspaces_on_added_by_id"
  add_index "asana_workspaces", ["auth_endpoint_id"], name: "index_asana_workspaces_on_auth_endpoint_id"
  add_index "asana_workspaces", ["node_id"], name: "index_asana_workspaces_on_node_id"

  create_table "delivery_dates", force: true do |t|
    t.integer  "node_id"
    t.integer  "target_type"
    t.integer  "envrionment_id"
    t.integer  "milestone_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delivery_dates", ["envrionment_id"], name: "index_delivery_dates_on_envrionment_id"
  add_index "delivery_dates", ["milestone_id"], name: "index_delivery_dates_on_milestone_id"
  add_index "delivery_dates", ["node_id"], name: "index_delivery_dates_on_node_id"

  create_table "dependables", force: true do |t|
    t.integer  "node_id"
    t.integer  "phase_id"
    t.integer  "task_id"
    t.integer  "dependentNode_id"
    t.integer  "dependentPhase_id"
    t.integer  "dependentTask_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dependables", ["dependentNode_id"], name: "index_dependables_on_dependentNode_id"
  add_index "dependables", ["dependentPhase_id"], name: "index_dependables_on_dependentPhase_id"
  add_index "dependables", ["dependentTask_id"], name: "index_dependables_on_dependentTask_id"
  add_index "dependables", ["node_id"], name: "index_dependables_on_node_id"
  add_index "dependables", ["phase_id"], name: "index_dependables_on_phase_id"
  add_index "dependables", ["task_id"], name: "index_dependables_on_task_id"

  create_table "environments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "functional_design_documents", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "git_hub_accounts", force: true do |t|
    t.string   "oauth"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  add_index "git_hub_accounts", ["user_id"], name: "index_git_hub_accounts_on_user_id"

  create_table "git_hub_issues", force: true do |t|
    t.integer  "gitHubID",   limit: 255
    t.integer  "number",     limit: 255
    t.string   "title"
    t.date     "created"
    t.date     "updated"
    t.date     "closed"
    t.string   "body"
    t.integer  "node_id"
    t.integer  "repo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "git_hub_issues", ["node_id"], name: "index_git_hub_issues_on_node_id"
  add_index "git_hub_issues", ["repo_id"], name: "index_git_hub_issues_on_repo_id"

  create_table "git_hub_repos", force: true do |t|
    t.string   "repo"
    t.integer  "node_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "git_hub_repos", ["node_id"], name: "index_git_hub_repos_on_node_id"
  add_index "git_hub_repos", ["user_id"], name: "index_git_hub_repos_on_user_id"

  create_table "milestones", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.boolean  "major_release"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "native_issue_has_asanas", force: true do |t|
    t.integer  "asana_task_id"
    t.integer  "native_issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "native_issue_has_asanas", ["asana_task_id"], name: "index_native_issue_has_asanas_on_asana_task_id"
  add_index "native_issue_has_asanas", ["native_issue_id"], name: "index_native_issue_has_asanas_on_native_issue_id"

  create_table "native_issues", force: true do |t|
    t.string   "summary"
    t.text     "description"
    t.boolean  "enhancement"
    t.integer  "issue_with_id"
    t.integer  "resolved_with_id"
    t.boolean  "close_without_resolution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "added_by_id"
  end

  add_index "native_issues", ["added_by_id"], name: "index_native_issues_on_added_by_id"
  add_index "native_issues", ["issue_with_id"], name: "index_native_issues_on_issue_with_id"
  add_index "native_issues", ["resolved_with_id"], name: "index_native_issues_on_resolved_with_id"

  create_table "node_has_functional_design_documents", force: true do |t|
    t.integer  "node_id"
    t.integer  "FDD_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "presented"
  end

  add_index "node_has_functional_design_documents", ["FDD_id"], name: "index_node_has_functional_design_documents_on_FDD_id"
  add_index "node_has_functional_design_documents", ["node_id"], name: "index_node_has_functional_design_documents_on_node_id"

  create_table "node_has_phase_type_defaults", force: true do |t|
    t.integer  "node_id"
    t.integer  "phase_type_default_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "node_type_id"
  end

  add_index "node_has_phase_type_defaults", ["node_id"], name: "index_node_has_phase_type_defaults_on_node_id"
  add_index "node_has_phase_type_defaults", ["node_type_id"], name: "index_node_has_phase_type_defaults_on_node_type_id"
  add_index "node_has_phase_type_defaults", ["phase_type_default_id"], name: "index_node_has_phase_type_defaults_on_phase_type_default_id"

  create_table "node_has_themes", force: true do |t|
    t.integer  "node_id"
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "node_has_themes", ["node_id"], name: "index_node_has_themes_on_node_id"
  add_index "node_has_themes", ["theme_id"], name: "index_node_has_themes_on_theme_id"

  create_table "node_histories", force: true do |t|
    t.integer  "node_id"
    t.integer  "user_id"
    t.text     "log"
    t.integer  "log_type"
    t.integer  "other_node_id"
    t.integer  "other_reference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "node_histories", ["node_id"], name: "index_node_histories_on_node_id"
  add_index "node_histories", ["other_node_id"], name: "index_node_histories_on_other_node_id"
  add_index "node_histories", ["other_reference_id"], name: "index_node_histories_on_other_reference_id"
  add_index "node_histories", ["user_id"], name: "index_node_histories_on_user_id"

  create_table "node_types", force: true do |t|
    t.string   "name"
    t.boolean  "priorityEnabled"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "product_organizer"
    t.boolean  "product"
    t.boolean  "feature_organizer"
    t.boolean  "feature"
    t.boolean  "specification"
  end

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "nodeType_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "phase_id"
    t.text     "description"
    t.integer  "row_order"
    t.integer  "dev_status"
  end

  add_index "nodes", ["nodeType_id"], name: "index_nodes_on_nodeType_id"
  add_index "nodes", ["phase_id"], name: "index_nodes_on_phase_id"

  create_table "phase_type_def_has_phase_types", force: true do |t|
    t.integer  "phase_type_default_id"
    t.integer  "phase_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phase_type_def_has_phase_types", ["phase_type_default_id"], name: "index_phase_type_def_has_phase_types_on_phase_type_default_id"
  add_index "phase_type_def_has_phase_types", ["phase_type_id"], name: "index_phase_type_def_has_phase_types_on_phase_type_id"

  create_table "phase_type_defaults", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phase_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phases", force: true do |t|
    t.integer  "phaseType_id"
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dependencies_id"
    t.boolean  "status"
    t.integer  "progress_status"
  end

  add_index "phases", ["dependencies_id"], name: "index_phases_on_dependencies_id"

  create_table "profile_images", force: true do |t|
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profile_images", ["user_id"], name: "index_profile_images_on_user_id"

  create_table "question_has_responses", force: true do |t|
    t.integer  "question_id"
    t.integer  "response_id"
    t.boolean  "answers"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "question_has_responses", ["question_id"], name: "index_question_has_responses_on_question_id"
  add_index "question_has_responses", ["response_id"], name: "index_question_has_responses_on_response_id"

  create_table "questions", force: true do |t|
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "resolved_id"
    t.integer  "node_id"
    t.integer  "phase_id"
    t.integer  "asked_by_user_id"
  end

  add_index "questions", ["asked_by_user_id"], name: "index_questions_on_asked_by_user_id"
  add_index "questions", ["node_id"], name: "index_questions_on_node_id"
  add_index "questions", ["phase_id"], name: "index_questions_on_phase_id"
  add_index "questions", ["resolved_id"], name: "index_questions_on_resolved_id"

  create_table "responses", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responses", ["user_id"], name: "index_responses_on_user_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.boolean  "view_product"
    t.boolean  "edit_nodes"
    t.boolean  "prioritize"
    t.boolean  "manage_issues"
    t.boolean  "manage_phases"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "manage_people"
    t.boolean  "administrative"
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.integer  "phase_id"
    t.integer  "node_id"
    t.boolean  "requiredForRelease"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "questions_id"
    t.integer  "dependencies_id"
  end

  add_index "tasks", ["dependencies_id"], name: "index_tasks_on_dependencies_id"
  add_index "tasks", ["questions_id"], name: "index_tasks_on_questions_id"

  create_table "themes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_has_favorite_nodes", force: true do |t|
    t.integer  "user_id"
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_has_favorite_nodes", ["node_id"], name: "index_user_has_favorite_nodes_on_node_id"
  add_index "user_has_favorite_nodes", ["user_id"], name: "index_user_has_favorite_nodes_on_user_id"

  create_table "user_has_role_for_nodes", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "lead"
  end

  add_index "user_has_role_for_nodes", ["node_id"], name: "index_user_has_role_for_nodes_on_node_id"
  add_index "user_has_role_for_nodes", ["role_id"], name: "index_user_has_role_for_nodes_on_role_id"
  add_index "user_has_role_for_nodes", ["user_id"], name: "index_user_has_role_for_nodes_on_user_id"

# Could not dump table "users" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

end
