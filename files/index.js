#!/usr/bin/env node

const sgMail = require('@sendgrid/mail');
const fs = require('fs');
const path = require('path');

// Set the SendGrid API key
sgMail.setApiKey(process.env.SENDGRID_API_KEY);

// Define email parameters
const msg = {
  to: 'sai.samudrala@unisys.com', // Replace with the recipient's email address
  from: 'sai.samudrala@unisys.com',  // Replace with your verified sender email address
  subject: 'CodeQL and Secret Scanning Report',
  text: 'Please find the attached CodeQL and secret scanning reports.',
  attachments: [],
};

// Directory containing the reports
const reportDir = path.join(process.env.GITHUB_WORKSPACE, 'downloads', 'secrets');

// Read and attach all files in the directory
if (fs.existsSync(reportDir)) {
  const reportFiles = fs.readdirSync(reportDir);

  reportFiles.forEach((file) => {
    const filePath = path.join(reportDir, file);
    const fileContent = fs.readFileSync(filePath).toString('base64');
    
    msg.attachments.push({
      content: fileContent,
      filename: file,
      type: 'application/octet-stream', // Generic MIME type for binary files
      disposition: 'attachment',
    });
  });

  if (msg.attachments.length === 0) {
    console.error('No report files found in:', reportDir);
    process.exit(1);
  }
} else {
  console.error('Report directory not found:', reportDir);
  process.exit(1);
}

// Send the email
sgMail
  .send(msg)
  .then(() => console.log('Email sent successfully'))
  .catch((error) => {
    console.error('Error sending email:', error.toString());
    process.exit(1);
  });
