require 'bundler/inline'
require 'yaml'

gemfile do
  source 'https://rubygems.org'
  gem 'json_schema'
end

# Schemaオブジェクトの例
schema_data = YAML.safe_load(<<~SCHEMA)
  type: object
  properties:
    title:
      type: string
    content:
      type: string
SCHEMA

schema = JsonSchema.parse!(schema_data)

# デフォルトでadditionalProperties: trueなので、
# 定義していないプロパティextraを含む次のJSONのバリデーションが通る
p schema.validate(
  {
    'title' => 'こんにちは',
    'content' => '今日はいい天気ですね',
    'extra' => '!!!'
  }
)
# => [true, []]

# Schemaオブジェクトの例
schema_data = YAML.safe_load(<<~SCHEMA)
  type: object
  properties:
    title:
      type: string
    content:
      type: string
  additionalProperties: false
SCHEMA

schema = JsonSchema.parse!(schema_data)

# 定義していないプロパティextraを含む次のJSONのバリデーションは通らない
p schema.validate(
  {
    'title' => 'こんにちは',
    'content' => '今日はいい天気ですね',
    'extra' => '!!!!'
  }
)
# => [false, [#<JsonSchema::ValidationError: #: failed schema #: "extra" is not a permitted key.>]]

# Schemaオブジェクトの例
schema_data = YAML.safe_load(<<~SCHEMA)
  type: object
  properties:
    title:
      type: string
    content:
      type: string
  required:
    - title
SCHEMA

schema = JsonSchema.parse!(schema_data)

# titleフィールドを含まない次のJSONのバリデーションは通らない
p schema.validate(
  {
    'content' => '今日はいい天気ですね'
  }
)
# => [false, [#<JsonSchema::ValidationError: #: failed schema #: "title" wasn't supplied.>]]

# Schemaオブジェクトの例
# type: object
# properties:
#   title:
#     type: string
#   removed_at:
#     type: string
#     format: date-time
#     nullable: true

# 上のSchemaオブジェクトと等価なJSON Schemaの例
schema_data = YAML.safe_load(<<~SCHEMA)
  type: object
  properties:
    title:
      type: string
    removed_at:
      type:
        - string
        - "null"
      format: date-time
SCHEMA

schema = JsonSchema.parse!(schema_data)

# removed_atの値がnilのときもバリデーションが通る
p schema.validate(
  {
    'title' => 'こんにちは',
    'removed_at' => nil
  }
)
# => [true, []]

# JSON Schema互換の構造へ変換
def convert_nullable_to_nullable_types(schema)
  schema['properties'].transform_values! do |properties|
    if properties['type'] == 'object'
      convert_nullable_to_nullable_types(properties)
    end

    if properties['nullable']
      properties['type'] = [properties['type'], 'null']
      properties.delete('nullable')
    end

    properties
  end

  schema
end

schema = YAML.safe_load(<<~SCHEMA)
  type: object
  properties:
    title:
      type: string
    removed_at:
      type: string
      format: date-time
      nullable: true
    parent:
      type: object
      properties:
        title:
          type: string
        removed_at:
          type: string
          format: date-time
          nullable: true
SCHEMA

pp convert_nullable_to_nullable_types(schema)
# => {"type"=>"object",
#     "properties"=>
#      {"title"=>{"type"=>"string"},
#       "removed_at"=>{"type"=>["string", "null"], "format"=>"date-time"},
#       "parent"=>
#        {"type"=>"object",
#         "properties"=>
#          {"title"=>{"type"=>"string"},
#           "removed_at"=>{"type"=>["string", "null"], "format"=>"date-time"}}}}}
