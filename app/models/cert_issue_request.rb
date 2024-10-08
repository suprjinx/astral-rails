class CertIssueRequest
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :common_name, :string
  attribute :alt_names, array: :string, default: []
  attribute :exclude_cn_from_sans, :boolean, default: false
  attribute :format, :string, default: "pem"
  attribute :not_after, :datetime
  attribute :other_sans, array: :string, default: []
  attribute :private_key_format, :string, default: "pem"
  attribute :remove_roots_from_chain, :boolean, default: false
  attribute :ttl, :integer, default: Rails.configuration.astral[:cert_ttl]
  attribute :uri_sans, array: :string, default: []
  attribute :ip_sans, array: :string, default: []
  attribute :serial_number, :integer
  attribute :client_flag, :boolean, default: true
  attribute :code_signing_flag, :boolean, default: false
  attribute :email_protection_flag, :boolean, default: false
  attribute :server_flag, :boolean, default: true

  validates :common_name, presence: true
  validates :format, presence: true, inclusion: { in: %w[pem der pem_bundle] }
  validates :private_key_format, presence: true, inclusion: { in: %w[pem der pkcs8] }


  def fqdns
    alt_names + [ common_name ]
  end
end
