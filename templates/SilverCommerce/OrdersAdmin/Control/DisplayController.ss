<!DOCTYPE html>
<% require css('silverstripe/admin: client/dist/styles/bundle.css') %>
<% require css('silvercommerce/orders-admin: client/dist/css/display.css') %>

<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>{$Top.Type}: {$Object.FullRef}</title>
    </head>

    <body>
        <div class="container">
            <header class="header">
                <div class="row">
                    <div class="col-sm-8">
                        <div class="panel logopanel">
                            <div class="panel-body">
                                <% if $Logo.exists %>
                                    <img class="img-fluid logoimg" src="data:image/png;base64,{$LogoBase64(400,240)}" />
                                <% end_if %>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4 text-right">
                        <div class="panel contentpanel">
                            <h1 class="panel-heading">
                                {$Title}
                            </h1>
                            <div class="panel-body">
                                {$HeaderContent}
                            </div>
                        </div>
                    </div>
                </div>

                <hr/>

                <div class="row">
                    <% with $Object %>
                        <div class="<% if $isDeliverable %>col-sm-3<% else %>col-sm-4<% end_if %>">
                            <div class="panel">
                                <div class="panel-heading">
                                    <%t OrdersAdmin.IssuedTo "Issued To" %>
                                </div>
                                <div class="panel-body">
                                    $FirstName $Surname<br/>
                                    <% if $Company %>$Company<br/><% end_if %>
                                    $Address1<br/>
                                    <% if $Address2 %>$Address2<br/><% end_if %>
                                    $City<br/>
                                    $PostCode<br/>
                                    $Country
                                </div>
                            </div>
                        </div>

                        <% if $isDeliverable %>
                            <div class="col-sm-3">
                                <div class="panel">
                                    <div class="panel-heading">
                                        <%t OrdersAdmin.DeliverTo "Deliver To" %>
                                    </div>
                                    <div class="panel-body">
                                        $DeliveryFirstName $DeliverySurname<br/>
                                        <% if $DeliveryCompany %>$DeliveryCompany<br/><% end_if %>
                                        $DeliveryAddress1<br/>
                                        <% if $DeliveryAddress2 %>$DeliveryAddress2<br/><% end_if %>
                                        $DeliveryCity<br/>
                                        $DeliveryPostCode<br/>
                                        $DeliveryCountry
                                    </div>
                                </div>
                            </div>
                        <% end_if %>

                        <div class="<% if $isDeliverable %>col-sm-6<% else %>col-sm-8<% end_if %>">
                            <table style="width: 100%;" class="table">
                                <tbody>
                                    <tr>
                                        <th><%t OrdersAdmin.RefNo "Ref No." %></th>
                                        <td>$FullRef</td>
                                    </tr>
                                    <tr>
                                        <th><%t OrdersAdmin.IssueDate "Issue Date" %></th>
                                        <td>$StartDate.Format('d/M/Y')</td>
                                    </tr>
                                    <tr>
                                        <th><% if $Top.Type == "Estimate" %>
                                            <%t OrdersAdmin.ValidUntil "Valid Until" %>
                                        <% else %>
                                            <%t OrdersAdmin.DueOn "Due On" %>
                                        <% end_if %></th>
                                        <td>$EndDate.Format('d/M/Y')</td>
                                    </tr>
                                    <% if $Top.Type == "Invoice" %>
                                        <tr>
                                            <th><%t OrdersAdmin.Status "Status" %></th>
                                            <td>$TranslatedStatus</td>
                                        </tr>
                                    <% end_if %>
                                </tbody>
                            </table>
                        </div>
                    <% end_with %>
                </div>
            </header>

            <hr/>

            <main>
                <% with $Object %>
                    <table class="table">
                        <thead>
                            <tr>
                                <th class="stock-id text-left"><%t OrdersAdmin.StockID "Stock ID" %></th>
                                <th class="description text-left"><%t OrdersAdmin.Item "Item" %></th>
                                <th class="qty text-center"><%t OrdersAdmin.Qty "Qty" %></th>
                                <th class="unitprice text-right"><%t OrdersAdmin.UnitPrice "Unit Price" %></th>
                                <th class="unittax text-right"><%t OrdersAdmin.UnitTax "Unit Tax" %></th>
                                <th class="tax-type text-right"><%t OrdersAdmin.TaxType "Tax Type" %></th>
                            </tr>
                        </thead>
                        <tbody><% loop $Items %>
                            <tr>
                                <td class="text-left">{$StockID}</td>
                                <td class="text-left"><strong>{$Title}</strong>
                                    <% if $Customisations.exists %>
                                        <br />
                                        <em>$CustomisationHTML</em>
                                    <% end_if %>
                                </td>
                                <td class="text-center">{$Quantity}</td>
                                <td class="text-right">{$UnitPrice.Nice}</td>
                                <td class="text-right">{$UnitTax.Nice}</td>
                                <td class="text-right">{$TaxRate.Title}</td>
                            </tr>
                        <% end_loop %></tbody>
                    </table>
                <% end_with %>
            </main>

            <hr/>

            <footer class="row">
                <div class="col-sm-8 d-none d-md-block">
                    {$FooterContent}
                </div>

                <div class="col-sm-4">
                    <% with $Object %>
                        <table class="table total-table">
                            <tbody>
                                <tr>
                                    <th class="text-right"><%t OrdersAdmin.SubTotal "SubTotal" %></th>
                                    <td class="text-right">$SubTotal.Nice</td>
                                </tr>
        
                                <% if $DiscountTotal.RAW > 0 %>
                                    <tr>
                                        <th class="text-right"><%t OrdersAdmin.Discount "Discount" %></th>
                                        <td class="text-right">$DiscountTotal.Nice</td>
                                    </tr>
                                <% end_if %>
                                
                                <% if $PostagePrice.RAW > 0 %>
                                    <tr>
                                        <th class="text-right"><%t OrdersAdmin.Postage "Postage" %></th>
                                        <td class="text-right">$PostagePrice.Nice</td>
                                    </tr>
                                <% end_if %>

                                <tr>
                                    <th class="text-right"><%t OrdersAdmin.Tax 'Tax' %></th>
                                    <td class="text-right">{$TaxTotal.Nice}</td>
                                </tr>

                                <tr>
                                    <th class="text-right"><%t OrdersAdmin.GrandTotal "Grand Total" %></th>
                                    <td class="text-right">$Total.Nice</td>
                                </tr>
                            </tbody>
                        </table>
                    <% end_with %>
                </div>

                <div class="col-sm-8 hide-pdf d-block d-sm-none">
                    {$FooterContent}
                </div>

                <div class="col-sm-12 text-center">
                    <a class="btn btn-lg btn-primary font-icon-down-circled" href="{$Object.PDFLink()}">Download</a>
                </div>
            </footer> 
        <div>
    </body>
</html>