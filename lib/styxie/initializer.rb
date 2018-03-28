# frozen_string_literal: true
module Styxie
  module Initializer
    def styxie_initialize_with(data, cfg: styxie_configuration)
      cfg.merge! data
    end

    def styxie_initialize(klass: styxie_class, method: action_name, data: styxie_configuration, camel_case: false)
      json = styxie_formatted_data(data, camel_case).to_json
      result = <<-CODE
<script type="text/javascript">
//<![CDATA[
  if (typeof Styxie === 'undefined' || Styxie === null) {
    Styxie = {}
  }
  if (Styxie.applyInitializer) {
    Styxie.applyInitializer('#{klass}', '#{method}', #{json});
  } else {
    if (Styxie.initQueue == null) {
      Styxie.initQueue = []
    }
    Styxie.initQueue.push(['#{klass}', '#{method}', #{json}]);
  }
//]]>
</script>
      CODE

      result.html_safe
    end

    def styxie_configuration
      @styxie_initialize_with ||= {}
    end

    def styxie_class
      controller_path.tr('/', '_').camelize
    end

    def styxie_formatted_data(data, is_camel_case)
      return data unless is_camel_case
      data.deep_transform_keys { |key| key.to_s.camelcase(:lower) }
    end
  end
end
