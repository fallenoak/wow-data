module WOW::ADT::Records
  class MCNK < WOW::ADT::Records::Base
    HEADER_FIELDS = [
      [:uint32, :flags],
      [:uint32, :index_x],
      [:uint32, :index_y],
      [:uint32, :n_layers],
      [:uint32, :doodad_refs],
      [:uint32, :offset_mcvt],
      [:uint32, :offset_mcnr],
      [:uint32, :offset_mcly],
      [:uint32, :offset_mcrf],
      [:uint32, :offset_mcal],
      [:uint32, :size_alpha],
      [:uint32, :offset_mcsh],
      [:uint32, :size_shadow],
      [:uint32, :area_id],
      [:uint32, :n_map_obj_refs],
      [:uint32, :holes],
      [:uint32, :lq_texture_map1],
      [:uint32, :lq_texture_map2],
      [:uint32, :lq_texture_map3],
      [:uint32, :lq_texture_map4],
      [:uint32, :pred_tex],
      [:uint32, :no_effect_doodad],
      [:uint32, :offset_mcse],
      [:uint32, :n_sound_emitters],
      [:uint32, :offset_mclq],
      [:uint32, :size_liquid],
      [:float,  :position1],
      [:float,  :position2],
      [:float,  :position3],
      [:uint32, :offset_mccv],
      [:uint32, :offset_mclv],
      [:uint32, :unused]
    ]

    HEADER_STRUCT = Struct.new(*HEADER_FIELDS.map { |f| f[1] })

    attr_reader :header

    def parse
      @header = HEADER_STRUCT.new
      parse_header
    end

    def parse_header
      HEADER_FIELDS.each do |field_definition|
        field_type, field_name = field_definition
        field_value = send("read_#{field_type}")
        @header[field_name] = field_value
      end
    end
  end
end
