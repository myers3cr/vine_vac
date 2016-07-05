class Contact < MailForm::Base

  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\‐]+)@([\w\‐]+\.)+([\w]{2,})\z/i
  attribute :message, validate: true

  def headers
    {
      subject: "Vineyard Vacations Contact",
      to: "myers3.cr@gmail.com",
      from: %("Vineyard Vacations" <myers3.cr@gmail.com>)
      # from: "myers3.cr@gmail.com"
    }
  end
end