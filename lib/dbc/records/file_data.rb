module WOW::DBC::Records
  class FileData < WOW::DBC::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:string, :file_name],
      [:string, :file_path]
    ]
  end
end
