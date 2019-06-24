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

    def styxie_include
      result = <<~CODE
        <script type="text/javascript">
        if (window.Styxie == null) { window.Styxie = {}; }

        window.Styxie.Initializers = {};
        if (window.Styxie.initQueue == null) { window.Styxie.initQueue = []; }

        window.Styxie.applyInitializer = function(klass, method, json) {
          const initializer = this.Initializers[klass];
          if (!initializer) { return; }

          if (initializer.initialize) {
            initializer.initialize(json);
          }

          if (initializer[method]) {
            return initializer[method](json);
          }
        };

        window.Styxie.deferredInit = function() {
          for (let args of Array.from(this.initQueue)) { this.applyInitializer.apply(this, args); }
          return this.initQueue = [];
        };

        window.initStyxie = () => {
          return this.Styxie.deferredInit();
        };
        </script>
      CODE

      result.html_safe
    end
    
  end
end
