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

ActiveRecord::Schema.define(version: 20151107022621) do

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

  create_table "native_issues", force: true do |t|
    t.string   "summary"
    t.text     "description"
    t.boolean  "enhancement"
    t.integer  "issue_with_id"
    t.integer  "resolved_with_id"
    t.boolean  "close_without_resolution"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "native_issues", ["issue_with_id"], name: "index_native_issues_on_issue_with_id"
  add_index "native_issues", ["resolved_with_id"], name: "index_native_issues_on_resolved_with_id"

  create_table "node_has_functional_design_documents", force: true do |t|
    t.integer  "node_id"
    t.integer  "FDD_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "questions", force: true do |t|
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "resolved_id"
    t.integer  "node_id"
    t.integer  "phase_id"
  end

  add_index "questions", ["node_id"], name: "index_questions_on_node_id"
  add_index "questions", ["phase_id"], name: "index_questions_on_phase_id"
  add_index "questions", ["resolved_id"], name: "index_questions_on_resolved_id"

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

  create_table "user_has_favorite_nodes", force: true do |t|
    t.integer  "user_id"
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_has_favorite_nodes", ["node_id"], name: "index_user_has_favorite_nodes_on_node_id"
  add_index "user_has_favorite_nodes", ["user_id"], name: "index_user_has_favorite_nodes_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "power_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
