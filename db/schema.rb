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

ActiveRecord::Schema.define(version: 20160107160113) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "addr_obj_id"
    t.string   "addr_obj_type"
    t.integer  "province_id"
    t.integer  "city_id"
    t.string   "street"
    t.string   "post_code"
    t.integer  "status",        default: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "agent_day_tradetotals", force: :cascade do |t|
    t.integer  "agent_id"
    t.date     "trade_date"
    t.decimal  "total_amount",      precision: 12, scale: 2, default: 0.0
    t.integer  "total_count",                                default: 0
    t.decimal  "wechat_amount",     precision: 12, scale: 2, default: 0.0
    t.integer  "wechat_count",                               default: 0
    t.decimal  "alipay_amount",     precision: 12, scale: 2, default: 0.0
    t.integer  "alipay_count",                               default: 0
    t.decimal  "t0_amount",         precision: 12, scale: 2, default: 0.0
    t.integer  "t0_count",                                   default: 0
    t.decimal  "t1_amount",         precision: 12, scale: 2, default: 0.0
    t.integer  "t1_count",                                   default: 0
    t.decimal  "expected_amount",   precision: 12, scale: 2, default: 0.0
    t.decimal  "actual_amount",     precision: 12, scale: 2, default: 0.0
    t.decimal  "diff_amount",       precision: 12, scale: 2, default: 0.0
    t.decimal  "diff_total_amount", precision: 12, scale: 2, default: 0.0
    t.integer  "status",                                     default: 0
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "agents", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "cooperation_type_id"
    t.datetime "cooperation_date"
    t.integer  "t0_enabled"
    t.string   "bank_biz_types"
    t.text     "cooperation_location"
    t.decimal  "deposit",              precision: 12, scale: 2
    t.decimal  "amounts_payable",      precision: 12, scale: 2
    t.integer  "status",                                        default: 0
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  create_table "agents_contacts", id: false, force: :cascade do |t|
    t.integer "agent_id"
    t.integer "contact_id"
  end

  add_index "agents_contacts", ["agent_id"], name: "index_agents_contacts_on_agent_id"
  add_index "agents_contacts", ["contact_id"], name: "index_agents_contacts_on_contact_id"

  create_table "bank_cards", force: :cascade do |t|
    t.integer  "bankcard_obj_id"
    t.string   "bankcard_obj_type"
    t.string   "bank_name"
    t.string   "bank_sub_branch"
    t.string   "account_name"
    t.string   "account_number"
    t.integer  "status",            default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "clearings", force: :cascade do |t|
    t.integer  "client_id"
    t.datetime "trade_date"
    t.integer  "trade_count"
    t.decimal  "trade_amount",       precision: 12, scale: 2
    t.decimal  "trade_fee",          precision: 12, scale: 2
    t.decimal  "clearing_amount",    precision: 12, scale: 2
    t.decimal  "actual_amount",      precision: 12, scale: 2
    t.integer  "clearing_status_id"
    t.integer  "status",                                      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_day_tradetotals", force: :cascade do |t|
    t.integer  "client_id"
    t.date     "trade_date"
    t.decimal  "total_amount",      precision: 12, scale: 2, default: 0.0
    t.integer  "total_count",                                default: 0
    t.decimal  "wechat_amount",     precision: 12, scale: 2, default: 0.0
    t.integer  "wechat_count",                               default: 0
    t.decimal  "alipay_amount",     precision: 12, scale: 2, default: 0.0
    t.integer  "alipay_count",                               default: 0
    t.decimal  "t0_amount",         precision: 12, scale: 2, default: 0.0
    t.integer  "t0_count",                                   default: 0
    t.decimal  "t1_amount",         precision: 12, scale: 2, default: 0.0
    t.integer  "t1_count",                                   default: 0
    t.decimal  "expected_amount",   precision: 12, scale: 2, default: 0.0
    t.decimal  "actual_amount",     precision: 12, scale: 2, default: 0.0
    t.decimal  "diff_amount",       precision: 12, scale: 2, default: 0.0
    t.decimal  "diff_total_amount", precision: 12, scale: 2, default: 0.0
    t.integer  "status",                                     default: 0
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "client_notes", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.text     "note"
    t.string   "tip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.integer  "shid"
    t.string   "shop_name"
    t.string   "shop_tel"
    t.integer  "category_id"
    t.integer  "salesman_id"
    t.decimal  "rate",                    precision: 12, scale: 6
    t.string   "join_date"
    t.decimal  "bank_card_limit_each",    precision: 12, scale: 2
    t.decimal  "bank_card_limit_month",   precision: 12, scale: 2
    t.decimal  "credit_card_limit_each",  precision: 12, scale: 2
    t.decimal  "credit_card_limit_month", precision: 12, scale: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "clients_contacts", id: false, force: :cascade do |t|
    t.integer "client_id"
    t.integer "contact_id"
  end

  add_index "clients_contacts", ["client_id"], name: "index_clients_contacts_on_client_id"
  add_index "clients_contacts", ["contact_id"], name: "index_clients_contacts_on_contact_id"

  create_table "code_tables", force: :cascade do |t|
    t.string   "name"
    t.string   "val"
    t.integer  "parent_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comfy_cms_blocks", force: :cascade do |t|
    t.string   "identifier",                      null: false
    t.text     "content",        limit: 16777215
    t.integer  "blockable_id"
    t.string   "blockable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_blocks", ["blockable_id", "blockable_type"], name: "index_comfy_cms_blocks_on_blockable_id_and_blockable_type"
  add_index "comfy_cms_blocks", ["identifier"], name: "index_comfy_cms_blocks_on_identifier"

  create_table "comfy_cms_categories", force: :cascade do |t|
    t.integer "site_id",          null: false
    t.string  "label",            null: false
    t.string  "categorized_type", null: false
  end

  add_index "comfy_cms_categories", ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_cat_type_and_label", unique: true

  create_table "comfy_cms_categorizations", force: :cascade do |t|
    t.integer "category_id",      null: false
    t.string  "categorized_type", null: false
    t.integer "categorized_id",   null: false
  end

  add_index "comfy_cms_categorizations", ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true

  create_table "comfy_cms_files", force: :cascade do |t|
    t.integer  "site_id",                                    null: false
    t.integer  "block_id"
    t.string   "label",                                      null: false
    t.string   "file_file_name",                             null: false
    t.string   "file_content_type",                          null: false
    t.integer  "file_file_size",                             null: false
    t.string   "description",       limit: 2048
    t.integer  "position",                       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_files", ["site_id", "block_id"], name: "index_comfy_cms_files_on_site_id_and_block_id"
  add_index "comfy_cms_files", ["site_id", "file_file_name"], name: "index_comfy_cms_files_on_site_id_and_file_file_name"
  add_index "comfy_cms_files", ["site_id", "label"], name: "index_comfy_cms_files_on_site_id_and_label"
  add_index "comfy_cms_files", ["site_id", "position"], name: "index_comfy_cms_files_on_site_id_and_position"

  create_table "comfy_cms_layouts", force: :cascade do |t|
    t.integer  "site_id",                                     null: false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                                       null: false
    t.string   "identifier",                                  null: false
    t.text     "content",    limit: 16777215
    t.text     "css",        limit: 16777215
    t.text     "js",         limit: 16777215
    t.integer  "position",                    default: 0,     null: false
    t.boolean  "is_shared",                   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_layouts", ["parent_id", "position"], name: "index_comfy_cms_layouts_on_parent_id_and_position"
  add_index "comfy_cms_layouts", ["site_id", "identifier"], name: "index_comfy_cms_layouts_on_site_id_and_identifier", unique: true

  create_table "comfy_cms_pages", force: :cascade do |t|
    t.integer  "site_id",                                         null: false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                                           null: false
    t.string   "slug"
    t.string   "full_path",                                       null: false
    t.text     "content_cache",  limit: 16777215
    t.integer  "position",                        default: 0,     null: false
    t.integer  "children_count",                  default: 0,     null: false
    t.boolean  "is_published",                    default: true,  null: false
    t.boolean  "is_shared",                       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_pages", ["parent_id", "position"], name: "index_comfy_cms_pages_on_parent_id_and_position"
  add_index "comfy_cms_pages", ["site_id", "full_path"], name: "index_comfy_cms_pages_on_site_id_and_full_path"

  create_table "comfy_cms_revisions", force: :cascade do |t|
    t.string   "record_type",                  null: false
    t.integer  "record_id",                    null: false
    t.text     "data",        limit: 16777215
    t.datetime "created_at"
  end

  add_index "comfy_cms_revisions", ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at"

  create_table "comfy_cms_sites", force: :cascade do |t|
    t.string  "label",                       null: false
    t.string  "identifier",                  null: false
    t.string  "hostname",                    null: false
    t.string  "path"
    t.string  "locale",      default: "en",  null: false
    t.boolean "is_mirrored", default: false, null: false
  end

  add_index "comfy_cms_sites", ["hostname"], name: "index_comfy_cms_sites_on_hostname"
  add_index "comfy_cms_sites", ["is_mirrored"], name: "index_comfy_cms_sites_on_is_mirrored"

  create_table "comfy_cms_snippets", force: :cascade do |t|
    t.integer  "site_id",                                     null: false
    t.string   "label",                                       null: false
    t.string   "identifier",                                  null: false
    t.text     "content",    limit: 16777215
    t.integer  "position",                    default: 0,     null: false
    t.boolean  "is_shared",                   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_snippets", ["site_id", "identifier"], name: "index_comfy_cms_snippets_on_site_id_and_identifier", unique: true
  add_index "comfy_cms_snippets", ["site_id", "position"], name: "index_comfy_cms_snippets_on_site_id_and_position"

  create_table "companies", force: :cascade do |t|
    t.integer  "address_id"
    t.text     "name"
    t.string   "short_name"
    t.date     "establish_date"
    t.string   "location"
    t.integer  "status",         default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "tel"
    t.string   "qq"
    t.string   "wechart"
    t.string   "cid"
    t.datetime "cid_verified_date"
    t.string   "roles",             default: ""
    t.integer  "status",            default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "contacts", ["name"], name: "index_contacts_on_name"
  add_index "contacts", ["tel"], name: "index_contacts_on_tel"

  create_table "imp_logs", force: :cascade do |t|
    t.integer  "uid"
    t.string   "title"
    t.string   "received_at"
    t.string   "mail_from"
    t.string   "detail",      default: ""
    t.integer  "status",      default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "imp_qf_clearings", force: :cascade do |t|
    t.string   "shid"
    t.string   "qsrq"
    t.string   "jybs"
    t.string   "jybj"
    t.string   "sxf"
    t.string   "jsje"
    t.string   "sjqsje"
    t.string   "qszt"
    t.integer  "imp_log_id"
    t.integer  "zt",         default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "imp_qf_customers", force: :cascade do |t|
    t.string   "shid"
    t.string   "hylx"
    t.string   "dm"
    t.string   "lxr"
    t.string   "sj"
    t.date     "rwsj"
    t.string   "sf"
    t.string   "cs"
    t.text     "dz"
    t.string   "ywy"
    t.string   "fl"
    t.string   "zdcm"
    t.decimal  "jjkdbxe",    precision: 12, scale: 2
    t.decimal  "jjkdyxe",    precision: 12, scale: 2
    t.decimal  "xykdbxe",    precision: 12, scale: 2
    t.decimal  "xykdyxe",    precision: 12, scale: 2
    t.integer  "imp_log_id"
    t.integer  "zt",                                  default: 0
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "imp_qf_trades", force: :cascade do |t|
    t.string   "shid"
    t.string   "zzh"
    t.string   "jyrq"
    t.string   "jylx"
    t.string   "jyjg"
    t.string   "jye"
    t.string   "zdcm"
    t.integer  "imp_log_id"
    t.integer  "zt",         default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pos_machines", force: :cascade do |t|
    t.string   "serial_number"
    t.integer  "client_id"
    t.string   "brand"
    t.string   "model"
    t.string   "info"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "sales_commissions", force: :cascade do |t|
    t.integer  "sales_commission_obj_id"
    t.string   "sales_commission_obj_type"
    t.string   "sales_type"
    t.integer  "start_count",                                        default: 0
    t.integer  "end_count",                                          default: 0
    t.decimal  "percent",                   precision: 12, scale: 2, default: 0.0
    t.integer  "status",                                             default: 0
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
  end

  create_table "salesman_day_tradetotals", force: :cascade do |t|
    t.integer  "salesman_id"
    t.date     "trade_date"
    t.decimal  "total_amount",      precision: 12, scale: 2, default: 0.0
    t.integer  "total_count",                                default: 0
    t.decimal  "wechat_amount",     precision: 12, scale: 2, default: 0.0
    t.integer  "wechat_count",                               default: 0
    t.decimal  "alipay_amount",     precision: 12, scale: 2, default: 0.0
    t.integer  "alipay_count",                               default: 0
    t.decimal  "t0_amount",         precision: 12, scale: 2, default: 0.0
    t.integer  "t0_count",                                   default: 0
    t.decimal  "t1_amount",         precision: 12, scale: 2, default: 0.0
    t.integer  "t1_count",                                   default: 0
    t.decimal  "expected_amount",   precision: 12, scale: 2, default: 0.0
    t.decimal  "actual_amount",     precision: 12, scale: 2, default: 0.0
    t.decimal  "diff_amount",       precision: 12, scale: 2, default: 0.0
    t.decimal  "diff_total_amount", precision: 12, scale: 2, default: 0.0
    t.integer  "status",                                     default: 0
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "salesmen", force: :cascade do |t|
    t.integer  "agent_id"
    t.integer  "contact_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "salesmen_contacts", id: false, force: :cascade do |t|
    t.integer "salesman_id"
    t.integer "contact_id"
  end

  add_index "salesmen_contacts", ["contact_id"], name: "index_salesmen_contacts_on_contact_id"
  add_index "salesmen_contacts", ["salesman_id"], name: "index_salesmen_contacts_on_salesman_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "trades", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "pos_machine_id"
    t.string   "sub_account",                              default: ""
    t.datetime "trade_date"
    t.integer  "trade_type_id"
    t.integer  "trade_result_id"
    t.decimal  "trade_amount",    precision: 12, scale: 2
    t.integer  "status",                                   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trades_total_mons", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "trade_date_year"
    t.integer  "trade_date_month"
    t.decimal  "total_amount",      precision: 12, scale: 2, default: 0.0
    t.integer  "total_count",                                default: 0
    t.decimal  "weichat_amount",    precision: 12, scale: 2, default: 0.0
    t.integer  "weichat_count",                              default: 0
    t.decimal  "alipay_amount",     precision: 12, scale: 2, default: 0.0
    t.integer  "alipay_count",                               default: 0
    t.decimal  "t0_amount",         precision: 12, scale: 2, default: 0.0
    t.integer  "t0_count",                                   default: 0
    t.decimal  "t1_amount",         precision: 12, scale: 2, default: 0.0
    t.integer  "t1_count",                                   default: 0
    t.decimal  "expected_amount",   precision: 12, scale: 2, default: 0.0
    t.decimal  "actual_amount",     precision: 12, scale: 2, default: 0.0
    t.decimal  "diff_amount",       precision: 12, scale: 2, default: 0.0
    t.decimal  "diff_total_amount", precision: 12, scale: 2, default: 0.0
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "trades_totals", force: :cascade do |t|
    t.integer  "client_id"
    t.date     "trade_date"
    t.decimal  "total_amount",      precision: 12, scale: 2, default: 0.0
    t.integer  "total_count",                                default: 0
    t.decimal  "weichat_amount",    precision: 12, scale: 2, default: 0.0
    t.integer  "weichat_count",                              default: 0
    t.decimal  "alipay_amount",     precision: 12, scale: 2, default: 0.0
    t.integer  "alipay_count",                               default: 0
    t.decimal  "t0_amount",         precision: 12, scale: 2, default: 0.0
    t.integer  "t0_count",                                   default: 0
    t.decimal  "t1_amount",         precision: 12, scale: 2, default: 0.0
    t.integer  "t1_count",                                   default: 0
    t.decimal  "expected_amount",   precision: 12, scale: 2, default: 0.0
    t.decimal  "actual_amount",     precision: 12, scale: 2, default: 0.0
    t.decimal  "diff_amount",       precision: 12, scale: 2, default: 0.0
    t.decimal  "diff_total_amount", precision: 12, scale: 2, default: 0.0
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "mobile"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
