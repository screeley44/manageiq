module EmsRefresh
  module Refreshers
    class OpenshiftRefresher < BaseRefresher
      include EmsRefresherMixin

      def parse_inventory(ems, _targets = nil)
        all_entities = ems.with_provider_connection(&:all_entities)
        all_entities.merge!(ems.with_provider_connection(:service => EmsKubernetes.ems_type, &:all_entities))
        EmsRefresh.log_inv_debug_trace(all_entities, "inv_hash:")
        EmsRefresh::Parsers::Openshift.ems_inv_to_hashes(all_entities)
      end
    end
  end
end
