
// class SPDXLicenseList {
//   String licenseListVersion;
//   List<SPDXLicenseDetails> licenses;
//   String releaseDate;
//
//   SPDXLicenseList({this.licenseListVersion, this.licenses, this.releaseDate});
//
//   SPDXLicenseList.fromJson(Map<String, dynamic> json) {
//     licenseListVersion = json['licenseListVersion'];
//     if (json['licenses'] != null) {
//       licenses = new List<SPDXLicenseDetails>();
//       json['licenses'].forEach((v) {
//         licenses.add(new SPDXLicenseDetails.fromJson(v));
//       });
//     }
//     releaseDate = json['releaseDate'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['licenseListVersion'] = this.licenseListVersion;
//     if (this.licenses != null) {
//       data['licenses'] = this.licenses.map((v) => v.toJson()).toList();
//     }
//     data['releaseDate'] = this.releaseDate;
//     return data;
//   }
// }
//
// class SPDXLicenseDetails {
//   bool isDeprecatedLicenseId;
//   bool isFsfLibre;
//   String licenseText;
//   String standardLicenseHeaderTemplate;
//   String standardLicenseTemplate;
//   String name;
//   String licenseComments;
//   String licenseId;
//   String standardLicenseHeader;
//   List<String> seeAlso;
//   bool isOsiApproved;
//
//   SPDXLicenseDetails(
//       {this.isDeprecatedLicenseId,
//       this.isFsfLibre,
//       this.licenseText,
//       this.standardLicenseHeaderTemplate,
//       this.standardLicenseTemplate,
//       this.name,
//       this.licenseComments,
//       this.licenseId,
//       this.standardLicenseHeader,
//       this.seeAlso,
//       this.isOsiApproved});
//
//   SPDXLicenseDetails.fromJson(Map<String, dynamic> json) {
//     isDeprecatedLicenseId = json['isDeprecatedLicenseId'];
//     isFsfLibre = json['isFsfLibre'];
//     licenseText = json['licenseText'];
//     standardLicenseHeaderTemplate = json['standardLicenseHeaderTemplate'];
//     standardLicenseTemplate = json['standardLicenseTemplate'];
//     name = json['name'];
//     licenseComments = json['licenseComments'];
//     licenseId = json['licenseId'];
//     standardLicenseHeader = json['standardLicenseHeader'];
//     seeAlso = json['seeAlso'].cast<String>();
//     isOsiApproved = json['isOsiApproved'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['isDeprecatedLicenseId'] = this.isDeprecatedLicenseId;
//     data['isFsfLibre'] = this.isFsfLibre;
//     data['licenseText'] = this.licenseText;
//     data['standardLicenseHeaderTemplate'] = this.standardLicenseHeaderTemplate;
//     data['standardLicenseTemplate'] = this.standardLicenseTemplate;
//     data['name'] = this.name;
//     data['licenseComments'] = this.licenseComments;
//     data['licenseId'] = this.licenseId;
//     data['standardLicenseHeader'] = this.standardLicenseHeader;
//     data['seeAlso'] = this.seeAlso;
//     data['isOsiApproved'] = this.isOsiApproved;
//
//     return data;
//   }
//
//   static Future<SPDXLicenseDetails> readLicenseDetails(String licenseId) async {
//     var resource =
//         Resource("package:spdx_licenses/licenses/" + licenseId + ".json");
//     var licenseString = await resource.readAsString(encoding: utf8);
//     return SPDXLicenseDetails.fromJson(json.decode(licenseString));
//   }
// }
