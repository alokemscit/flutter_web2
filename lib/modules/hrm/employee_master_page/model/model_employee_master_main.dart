class ModelEmployeeMasterMain {
  String? id;
  String? eno;
  String? desigId;
  String? desigName;
  String? depId;
  String? depName;
  String? name;
  String? img;
  String? gradeId;
  String? gradeName;
  String? sectionId;
  String? sectionName;
  String? empTypeId;
  String? empTypeName;
  String? jobStatusId;
  String? jobStatusName;
  String? doj;
  String? deptCatId;
  String? deptCatName;
  String? note;
  String? dob;
  String? fatherName;
  String? motherName;
  String? sposeName;
  String? nationalityId;
  String? nationalityName;
  String? code;
  String? genderId;
  String? genderName;
  String? religionId;
  String? religionName;
  String? maritalId;
  String? maritalName;
  String? bgId;
  String? bgName;
  String? identityId;
  String? identityName;
  String? identityNo;
  String? mob;
  String? email;
  String? isSeparated;

  ModelEmployeeMasterMain(
      {this.id,
      this.eno,
      this.desigId,
      this.desigName,
      this.depId,
      this.depName,
      this.name,
      this.img,
      this.gradeId,
      this.gradeName,
      this.sectionId,
      this.sectionName,
      this.empTypeId,
      this.empTypeName,
      this.jobStatusId,
      this.jobStatusName,
      this.doj,
      this.deptCatId,
      this.deptCatName,
      this.note,
      this.dob,
      this.fatherName,
      this.motherName,
      this.sposeName,
      this.nationalityId,
      this.nationalityName,
      this.code,
      this.genderId,
      this.genderName,
      this.religionId,
      this.religionName,
      this.maritalId,
      this.maritalName,
      this.bgId,
      this.bgName,
      this.identityId,
      this.identityName,
      this.identityNo,
      this.mob,
      this.email,
      this.isSeparated});

  ModelEmployeeMasterMain.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    eno = json['eno'];
    desigId = json['desig_id'].toString();
    desigName = json['desig_name'];
    depId = json['dep_id'].toString();
    depName = json['dep_name'];
    name = json['name'];
    img = json['img'];
    gradeId = json['grade_id'].toString();
    gradeName = json['grade_name'];
    sectionId = json['section_id'].toString();
    sectionName = json['section_name'];
    empTypeId = json['emp_type_id']..toString();
    empTypeName = json['emp_type_name'];
    jobStatusId = json['job_status_id'].toString();
    jobStatusName = json['job_status_name'];
    doj = json['doj'];
    deptCatId = json['dept_cat_id'].toString();
    deptCatName = json['dept_cat_name'];
    note = json['note'];
    dob = json['dob'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    sposeName = json['spose_name'];
    nationalityId = json['nationality_id'].toString();
    nationalityName = json['nationality_name'];
    code = json['code'];
    genderId = json['gender_id'].toString();
    genderName = json['gender_name'];
    religionId = json['religion_id'].toString();
    religionName = json['religion_name'];
    maritalId = json['marital_id'].toString();
    maritalName = json['marital_name'];
    bgId = json['bg_id'].toString();
    bgName = json['bg_name'];
    identityId = json['identity_id'].toString();
    identityName = json['identity_name'];
    identityNo = json['identity_no'];
    mob = json['mob'];
    email = json['email'];
    isSeparated = json['is_separated'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eno'] = this.eno;
    data['desig_id'] = this.desigId;
    data['desig_name'] = this.desigName;
    data['dep_id'] = this.depId;
    data['dep_name'] = this.depName;
    data['name'] = this.name;
    data['img'] = this.img;
    data['grade_id'] = this.gradeId;
    data['grade_name'] = this.gradeName;
    data['section_id'] = this.sectionId;
    data['section_name'] = this.sectionName;
    data['emp_type_id'] = this.empTypeId;
    data['emp_type_name'] = this.empTypeName;
    data['job_status_id'] = this.jobStatusId;
    data['job_status_name'] = this.jobStatusName;
    data['doj'] = this.doj;
    data['dept_cat_id'] = this.deptCatId;
    data['dept_cat_name'] = this.deptCatName;
    data['note'] = this.note;
    data['dob'] = this.dob;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['spose_name'] = this.sposeName;
    data['nationality_id'] = this.nationalityId;
    data['nationality_name'] = this.nationalityName;
    data['code'] = this.code;
    data['gender_id'] = this.genderId;
    data['gender_name'] = this.genderName;
    data['religion_id'] = this.religionId;
    data['religion_name'] = this.religionName;
    data['marital_id'] = this.maritalId;
    data['marital_name'] = this.maritalName;
    data['bg_id'] = this.bgId;
    data['bg_name'] = this.bgName;
    data['identity_id'] = this.identityId;
    data['identity_name'] = this.identityName;
    data['identity_no'] = this.identityNo;
    data['mob'] = this.mob;
    data['email'] = this.email;
    data['is_separated'] = this.isSeparated;
    return data;
  }
}
