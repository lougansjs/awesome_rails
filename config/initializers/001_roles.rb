# frozen_string_literal: true

Roles = YAML.safe_load File.open(Rails.root.join('config', 'roles.yml'))
