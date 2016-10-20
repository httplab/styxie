# frozen_string_literal: true
module Styxie
  module Initializer
    def styxie_initialize_with(data, cfg: styxie_configuration)
      cfg.merge! data
    end

    def styxie_initialize(klass: styxie_class, method: action_name, data: styxie_configuration, autorun: true)
      json = data.to_json
      init_call = autorun ? 'initStyxie();' : ''
      result = <<-CODE
<script type="text/javascript">
//<![CDATA[
  function initStyxie() {
    if (Styxie.Initializers.#{klass} && Styxie.Initializers.#{klass}.initialize)
    {
      Styxie.Initializers.#{klass}.initialize(#{json});
    }
    if (Styxie.Initializers.#{klass} && Styxie.Initializers.#{klass}['#{method}'])
    {
      Styxie.Initializers.#{klass}['#{method}'](#{json});
    }
  };
  #{init_call}
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
  end
end
