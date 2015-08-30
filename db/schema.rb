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

ActiveRecord::Schema.define(version: 20150830060556) do

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

  create_table "node_types", force: true do |t|
    t.string   "name"
    t.boolean  "priorityEnabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "nodeType_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "phase_id"
    t.text     "description"
  end

  add_index "nodes", ["nodeType_id"], name: "index_nodes_on_nodeType_id"
  add_index "nodes", ["phase_id"], name: "index_nodes_on_phase_id"

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
