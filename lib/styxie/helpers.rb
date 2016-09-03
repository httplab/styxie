# frozen_string_literal: true
module Styxie
  module Helpers
    def this_page?(mask)
      Array(mask).any? do |m|
        c, a = m.to_s.split('#')
        !(c.present? && c != controller_name || a.present? && a != action_name)
      end
    end

    def this_namespace?(namespace)
      # TODO: support nested namespaces?
      namespace == controller_path.split('/').first
    end
  end
end
