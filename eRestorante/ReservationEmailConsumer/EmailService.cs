using MimeKit;
using MailKit.Net.Smtp;
using Microsoft.Extensions.Configuration;

public class EmailService
{
    private readonly IConfiguration _configuration;

    public EmailService(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public void SendEmail(string recipientEmail, string message)
    {
        var emailConfig = _configuration.GetSection("Email");
        var emailMessage = new MimeMessage();


        var fromEmail = Environment.GetEnvironmentVariable("FromEmail");

        emailMessage.From.Add(new MailboxAddress("Restorante Reservation Service", fromEmail));
        emailMessage.To.Add(new MailboxAddress("Customer", recipientEmail));
        emailMessage.Subject = "New Reservation Added";
        emailMessage.Body = new TextPart("plain")
        {
            Text = message
        };

        using var client = new SmtpClient();
        try
        {
            client.Connect(emailConfig["SmtpServer"], int.Parse(emailConfig["SmtpPort"]), false);

            var smtpPass = Environment.GetEnvironmentVariable("SmtpPass");
            var smtpUser = Environment.GetEnvironmentVariable("SmtpUser");
            client.Authenticate(smtpUser, smtpPass);

            client.Send(emailMessage);
        }
        catch (Exception ex)
        {
            Console.WriteLine($"An error occurred while sending email to {recipientEmail}: {ex.Message}");
        }
        finally
        {
            client.Disconnect(true);
            client.Dispose();
        }
    }
}
