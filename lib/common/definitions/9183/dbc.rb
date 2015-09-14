module WOW::Definitions
  build 9183 do
    namespace :dbc do
      table :file_data do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :file_name,                   type: :string,  tc_value: ''
        e   2,    :file_path,                   type: :string,  tc_value: ''
      end
    end
  end
end
