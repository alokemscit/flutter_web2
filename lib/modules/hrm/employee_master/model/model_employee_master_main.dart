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
    img = json['img'].toString();
    gradeId = json['grade_id'].toString();
    gradeName = json['grade_name'];
    sectionId = json['section_id'].toString();
    sectionName = json['section_name'];
    empTypeId = json['emp_type_id'].toString();
     empTypeName = json['emp_type_name'];
     jobStatusId = json['job_status_id'].toString();
     jobStatusName = json['job_status_name'];
     doj = json['doj'].toString();
     deptCatId = json['dept_cat_id'].toString();
     deptCatName = json['dept_cat_name'];
     note = json['note'].toString();
     dob = json['dob'].toString();
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    sposeName = json['spose_name'];
    nationalityId = json['nationality_id'].toString();
    nationalityName = json['nationality_name'];
    code = json['code'].toString();
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
    identityNo = json['identity_no'].toString();
    mob = json['mob'].toString();
    email = json['email'];
    isSeparated = json['is_separated'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['eno'] = eno;
    data['desig_id'] = desigId;
    data['desig_name'] = desigName;
    data['dep_id'] = depId;
    data['dep_name'] = depName;
    data['name'] = name;
    data['img'] = img;
    data['grade_id'] = gradeId;
    data['grade_name'] = gradeName;
    data['section_id'] = sectionId;
    data['section_name'] = sectionName;
    data['emp_type_id'] = empTypeId;
    data['emp_type_name'] = empTypeName;
    data['job_status_id'] = jobStatusId;
    data['job_status_name'] = jobStatusName;
    data['doj'] = doj;
    data['dept_cat_id'] = deptCatId;
    data['dept_cat_name'] = deptCatName;
    data['note'] = note;
    data['dob'] = dob;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['spose_name'] = sposeName;
    data['nationality_id'] = nationalityId;
    data['nationality_name'] = nationalityName;
    data['code'] = code;
    data['gender_id'] = genderId;
    data['gender_name'] = genderName;
    data['religion_id'] = religionId;
    data['religion_name'] = religionName;
    data['marital_id'] = maritalId;
    data['marital_name'] = maritalName;
    data['bg_id'] = bgId;
    data['bg_name'] = bgName;
    data['identity_id'] = identityId;
    data['identity_name'] = identityName;
    data['identity_no'] = identityNo;
    data['mob'] = mob;
    data['email'] = email;
    data['is_separated'] = isSeparated;
    return data;
  }
}
