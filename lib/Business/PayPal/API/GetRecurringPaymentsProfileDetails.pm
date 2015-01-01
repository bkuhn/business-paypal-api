# This file is part of Business:PayPal:API Module.   License: Same as Perl.  See its README for details.
package Business::PayPal::API::GetRecurringPaymentsProfileDetails;

use 5.008001;
use strict;
use warnings;

use SOAP::Lite 0.67;
use Business::PayPal::API ();

our @ISA = qw(Business::PayPal::API);


our @EXPORT_OK = qw(GetRecurringPaymentsProfileDetails);  ## fake exporter

sub GetRecurringPaymentsProfileDetails {
    my $self = shift;
    my %args = @_;

    my @trans = 
      (
       $self->version_req,
       SOAP::Data->name( ProfileID => $args{ProfileID} )->type( 'xs:string' ),
      );

    my $request = SOAP::Data->name
      ( GetRecurringPaymentsProfileDetailsRequest => \SOAP::Data->value( @trans ) )
	->type("ns:GetRecurringPaymentsProfileDetailsRequestType");

    my $som = $self->doCall( GetRecurringPaymentsProfileDetailsReq => $request )
      or return;

    my $path = '/Envelope/Body/GetRecurringPaymentsProfileDetailsResponse';

    my %response = ();
    unless( $self->getBasic($som, $path, \%response) ) {
        $self->getErrors($som, $path, \%response);
        return %response;
    }

    $path .= '/GetRecurringPaymentsProfileDetailsResponseDetails';
    $self->getFields($som, $path, \%response,
                     { ProfileID                 => 'ProfileID',
                       ProfileStatus             => 'ProfileStatus',
                       Description               => 'Description',
                       AggregateAmount           => 'AggregateAmount',
                       RegularAmountPaid         => 'RegularAmountPaid',
                       FinalPaymentDueDate       => 'FinalPaymentDueDate',
                       TrialAmountPaid           => 'TrialAmountPaid',
                       AggregateOptionalAmount   => 'AggregateOptionalAmount',
                       AutoBillOutstandingAmount => 'AutoBillOutstandingAmount',
                       MaxFailedPayments         => 'MaxFailedPayments',
                       CountryName               => 'SubscriberShippingAddress/CountryName',
                       CityName                  => 'SubscriberShippingAddress/CityName',
                       Street1                   => 'SubscriberShippingAddress/Street1',
                       Street2                   => 'SubscriberShippingAddress/Street2',
                       PostalCode                => 'SubscriberShippingAddress/PostalCode',
                       AddressID                 => 'SubscriberShippingAddress/AddressID',
                       ExternalAddressID         => 'SubscriberShippingAddress/ExternalAddressID',
                       AddressOwner              => 'SubscriberShippingAddress/AddressOwner',
                       Phone                     => 'SubscriberShippingAddress/Phone',
                       AddressStatus             => 'SubscriberShippingAddress/AddressStatus',
                       Name                      => 'SubscriberShippingAddress/Name',
                       StateOrProvince           => 'SubscriberShippingAddress/StateOrProvince',
                       BillingStartDate          => 'BillingStartDate',
                       SubscriberName            => 'SubscriberName',
                       TaxAmount                 => 'CurrentRecurringPaymentsPeriod/TaxAmount',
                       Amount                    => 'CurrentRecurringPaymentsPeriod/Amount',
                       ShippingAmount            => 'CurrentRecurringPaymentsPeriod/ShippingAmount',
                       TotalBillingCycles        => 'CurrentRecurringPaymentsPeriod/TotalBillingCycles',
                       BillingPeriod             => 'CurrentRecurringPaymentsPeriod/BillingPeriod',


                                                 #          'LastPaymentAmount' => '10.00',
                                                 #          'NextBillingDate' => '2014-01-17T10:00:00Z',
                                                 #          'NumberCyclesRemaining' => '-2',
                                                 #          'NumberCyclesCompleted' => '2',
                                                 #          'LastPaymentDate' => '2013-12-17T10:59:31Z',
                                                 #          'FailedPaymentCount' => '0',
                                                 #          'OutstandingBalance' => '0.00'
                                                 #        }, 'RecurringPaymentsSummaryType' ),
                                                 # '{urn:ebay:apis:eBLBaseComponents}RecurringPaymentsSummary',
                                                 # bless( {
                                                 #          'TaxAmount' => '0.00',
                                                 #          'Amount' => '10.00',
                                                 #          'ShippingAmount' => '0.00',
                                                 #          'TotalBillingCycles' => '0',
                                                 #          'BillingFrequency' => '1',
                                                 #          'BillingPeriod' => 'Month'
                                                 #        }, 'BillingPeriodDetailsType' ),
                                                 # '{urn:ebay:apis:eBLBaseComponents}RegularRecurringPaymentsPeriod',

                     }
                    );

    return %response;
}

1;
__END__

=head1 NAME

Business::PayPal::API::GetRecurringPaymentsProfileDetails - PayPal GetRecurringPaymentsProfileDetails API

=head1 SYNOPSIS

  use Business::PayPal::API::GetRecurringPaymentsProfileDetails;
  my $pp = new Business::PayPal::API::GetRecurringPaymentsProfileDetails ( ... );

or

  ## see Business::PayPal::API documentation for parameters
  use Business::PayPal::API qw(GetRecurringPaymentsProfileDetails);
  my $pp = new Business::PayPal::API( ... );

  my %response = $pp->GetRecurringPaymentsProfileDetails( ProfileID => $profileID, );

=head1 DESCRIPTION

B<Business::PayPal::API::GetRecurringPaymentsProfileDetails> implements PayPal's
B<GetRecurringPaymentsProfileDetails> API using SOAP::Lite to make direct API calls to
PayPal's SOAP API server. It also implements support for testing via
PayPal's I<sandbox>. Please see L<Business::PayPal::API> for details
on using the PayPal sandbox.

=head2 GetRecurringPaymentsProfileDetails

Implements PayPal's B<GetRecurringPaymentsProfileDetails> API call. Supported
parameters include:

  TransactionID

as described in the PayPal "Web Services API Reference" document.

Returns a hash containing the transaction details, including these fields:


As described in the API document.


Example:

  my %resp = $pp->GetRecurringPaymentsProfileDetails( ProfileID => $trans_id );
  print "Payer: $resp{ProfileStatus}\n";


=head2 ERROR HANDLING

See the B<ERROR HANDLING> section of B<Business::PayPal::API> for
information on handling errors.

=head2 EXPORT

None by default.

=head1 SEE ALSO

L<https://developer.paypal.com/en_US/pdf/PP_APIReference.pdf>

=head1 AUTHOR

Bradley M. Kuhn E<lt>bkuhn@ebb.orgE<gt>

adapted from work by:
Scot Wiersdorf E<lt>scott@perlcode.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by Scott Wiersdorf
Copyright (C) 2013 by Bradley M. Kuhn

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.5 or,
at your option, any later version of Perl 5 you may have available.


=cut
