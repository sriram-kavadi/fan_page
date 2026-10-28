$docxPath = "d:\project\fan_page\Project_Report_Output\Project_Report_Final.docx"
$pdfPath = "d:\project\fan_page\Project_Report_Output\Project_Report_Final.pdf"

Write-Host "Starting MS Word COM automation..."
$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = [Microsoft.Office.Interop.Word.WdAlertLevel]::wdAlertsNone

try {
    Write-Host "Opening document: $docxPath"
    $doc = $word.Documents.Open($docxPath, $false, $true) # ReadOnly = true
    
    Write-Host "Updating document fields..."
    $doc.Fields.Update()
    
    # wdFormatPDF = 17
    Write-Host "Exporting to PDF: $pdfPath"
    $doc.SaveAs([ref]$pdfPath, [ref]17)
    
    $doc.Close([ref]$false)
    Write-Host "SUCCESS: PDF generated successfully!"
} catch {
    Write-Host "ERROR converting to PDF: $_"
} finally {
    $word.Quit()
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
}
