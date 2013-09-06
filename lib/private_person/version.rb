module PrivatePerson
  VERSION = File.read(File.expand_path('../../../VERSION', __FILE__))

  def self.version_string
    "PrivatePerson version #{PrivatePerson::VERSION}"
  end
end
