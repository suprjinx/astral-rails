module Services
  class VaultService
    def initialize
      # TODO create a new token for use in the session
      @client = Vault::Client.new(
        address: Rails.application.config.astral[:vault_addr],
        token: Rails.application.config.astral[:vault_token]
      )
    end

    def issue_cert(cert_issue_request)
      # Generate the TLS certificate using the intermediate CA
      tls_cert = @client.logical.write(Rails.application.config.astral[:vault_cert_path],
          common_name: cert_issue_request.common_name,
          ttl: cert_issue_request.ttl,
          ip_sans: cert_issue_request.ip_sans,
          format: cert_issue_request.format)
      tls_cert.data
    end
  end
end
