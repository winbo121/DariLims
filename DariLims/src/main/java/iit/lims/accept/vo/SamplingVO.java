
package iit.lims.accept.vo;

import org.springframework.web.multipart.MultipartFile;

import iit.lims.accept.vo.AcceptVO;

public class SamplingVO extends AcceptVO {

	private String pick_dt;/*채취 일시*/
	private String pick_time;/*채취 일시 시간*/
	private String pick_lc;/*채취 위치*/
	private String pick_purps;/*채취 목적*/
	private String prduct_knd;/*제품 종류*/
	private String prduct_qy;/*제품 량*/
	private String lt_mg;/*로트 크기*/
	private String lt_co;/*로트 수*/
	private String pick_dn;/*채취 밀도*/
	private String pick_place;/*채취 장소*/
	private String pick_place_method;/*채취 장소 방법*/
	private byte[] pick_place_photo;/*채취 장소 사진*/
	private String pick_utnsil_nm;/*채취 기구 명*/
	private String pick_utnsil_manp;/*채취 기구 제원*/
	private byte[] pick_utnsil_photo;/*채취 기구 사진*/
	private String increment_pick_qy;/*인크리먼트 채취 량*/
	private String increment_co;/*인크리먼트 수*/
	private byte[] lt_atch_photo1;/*로트 첨부 사진1*/
	private byte[] lt_atch_photo2;/*로트 첨부 사진2*/
	private byte[] lt_atch_photo3;/*로트 첨부 사진3*/
	private byte[] lt_atch_photo4;/*로트 첨부 사진4*/
	private String outage_mixtrsplore_dt;/*감량 혼합시료 일시*/
	private String outage_mixtrsplore_qy;/*감량 혼합시료 량*/
	private String mesure_utnsil_nm;/*측정 기구 명*/
	private String mesure_scope;/*측정 범위*/
	private String mesure_mth;/*측정 방법*/
	private byte[] mesure_atch_photo1;/*측정 첨부 사진1*/
	private byte[] mesure_atch_photo2;/*측정 첨부 사진2*/
	private byte[] mesure_atch_photo3;/*측정 첨부 사진3*/
	private byte[] mesure_atch_photo4;/*측정 첨부 사진4*/
	
	private String pick_lt_no;/*채취 로트 번호*/
	private String increment_no;/*인크리먼트 번호*/
	private String lt_dt;/*로트 일시*/
	private String lt_pick_qy;/*로트 채취 량*/
	
	private String pick_mesure_no;/*채취 측정 번호*/
	private String splore_no;/*시료 번호*/
	private String mesure_dm;/*측정 직경*/
	private String mesure_lt;/*측정 길이*/
	private String bio_no;/*고형성적서 번호*/
	
	private String lt_dt_h, lt_dt_m;
	private String outage_mixtrsplore_dth, outage_mixtrsplore_dtm;
	
	private String pick_place_pn;/*채취 장소 사진이름*/
	private String pick_utnsil_pn;/*채취 기구 사진이름*/
	private String lt_atch_pn1;/*로트 첨부 사진이름1*/
	private String lt_atch_pn2;/*로트 첨부 사진이름2*/
	private String lt_atch_pn3;/*로트 첨부 사진이름3*/
	private String lt_atch_pn4;/*로트 첨부 사진이름4*/
	private String mesure_atch_pn1;/*측정 첨부 사진이름1*/
	private String mesure_atch_pn2;/*측정 첨부 사진이름2*/
	private String mesure_atch_pn3;/*측정 첨부 사진이름3*/
	private String mesure_atch_pn4;/*측정 첨부 사진이름4*/
	
	private MultipartFile pick_place_photo_img, pick_utnsil_photo_img, lt_atch_photo1_img, lt_atch_photo2_img, lt_atch_photo3_img, lt_atch_photo4_img,
							mesure_atch_photo1_img, mesure_atch_photo2_img, mesure_atch_photo3_img, mesure_atch_photo4_img;
	
	private byte[] down_file_data;
	private String down_file_nm;
	
	private String sampling_yn;
	
	private String solid_gbn;
	private String rawmtrl_gbn;
	private String width;
	private String vrticl;
	private String sungsang1;
	private String sungsang2;
	private String sungsang3;
	private String sungsang4;
	private String sungsang5;
	private String sungsang6;

	private String sungsang0; //원재료의 종류 및 구성비율	
	private String sungsang_etc; //금속성분 함유량 - 기타	

	private String pick_utnsil_unit;
	
	public String getPick_dt() {
		return pick_dt;
	}
	public void setPick_dt(String pick_dt) {
		this.pick_dt = pick_dt;
	}
	public String getPick_lc() {
		return pick_lc;
	}
	public void setPick_lc(String pick_lc) {
		this.pick_lc = pick_lc;
	}
	public String getPick_purps() {
		return pick_purps;
	}
	public void setPick_purps(String pick_purps) {
		this.pick_purps = pick_purps;
	}
	public String getPrduct_knd() {
		return prduct_knd;
	}
	public void setPrduct_knd(String prduct_knd) {
		this.prduct_knd = prduct_knd;
	}
	public String getPrduct_qy() {
		return prduct_qy;
	}
	public void setPrduct_qy(String prduct_qy) {
		this.prduct_qy = prduct_qy;
	}
	public String getLt_mg() {
		return lt_mg;
	}
	public void setLt_mg(String lt_mg) {
		this.lt_mg = lt_mg;
	}
	public String getLt_co() {
		return lt_co;
	}
	public void setLt_co(String lt_co) {
		this.lt_co = lt_co;
	}
	public String getPick_dn() {
		return pick_dn;
	}
	public void setPick_dn(String pick_dn) {
		this.pick_dn = pick_dn;
	}
	public String getPick_place() {
		return pick_place;
	}
	public void setPick_place(String pick_place) {
		this.pick_place = pick_place;
	}
	public byte[] getPick_place_photo() {
		return pick_place_photo;
	}
	public void setPick_place_photo(byte[] pick_place_photo) {
		this.pick_place_photo = pick_place_photo;
	}
	public String getPick_utnsil_nm() {
		return pick_utnsil_nm;
	}
	public void setPick_utnsil_nm(String pick_utnsil_nm) {
		this.pick_utnsil_nm = pick_utnsil_nm;
	}
	public String getPick_utnsil_manp() {
		return pick_utnsil_manp;
	}
	public void setPick_utnsil_manp(String pick_utnsil_manp) {
		this.pick_utnsil_manp = pick_utnsil_manp;
	}
	public byte[] getPick_utnsil_photo() {
		return pick_utnsil_photo;
	}
	public void setPick_utnsil_photo(byte[] pick_utnsil_photo) {
		this.pick_utnsil_photo = pick_utnsil_photo;
	}
	public String getIncrement_pick_qy() {
		return increment_pick_qy;
	}
	public void setIncrement_pick_qy(String increment_pick_qy) {
		this.increment_pick_qy = increment_pick_qy;
	}
	public String getIncrement_co() {
		return increment_co;
	}
	public void setIncrement_co(String increment_co) {
		this.increment_co = increment_co;
	}
	public byte[] getLt_atch_photo1() {
		return lt_atch_photo1;
	}
	public void setLt_atch_photo1(byte[] lt_atch_photo1) {
		this.lt_atch_photo1 = lt_atch_photo1;
	}
	public byte[] getLt_atch_photo2() {
		return lt_atch_photo2;
	}
	public void setLt_atch_photo2(byte[] lt_atch_photo2) {
		this.lt_atch_photo2 = lt_atch_photo2;
	}
	public byte[] getLt_atch_photo3() {
		return lt_atch_photo3;
	}
	public void setLt_atch_photo3(byte[] lt_atch_photo3) {
		this.lt_atch_photo3 = lt_atch_photo3;
	}
	public byte[] getLt_atch_photo4() {
		return lt_atch_photo4;
	}
	public void setLt_atch_photo4(byte[] lt_atch_photo4) {
		this.lt_atch_photo4 = lt_atch_photo4;
	}
	public String getOutage_mixtrsplore_dt() {
		return outage_mixtrsplore_dt;
	}
	public void setOutage_mixtrsplore_dt(String outage_mixtrsplore_dt) {
		this.outage_mixtrsplore_dt = outage_mixtrsplore_dt;
	}
	public String getOutage_mixtrsplore_qy() {
		return outage_mixtrsplore_qy;
	}
	public void setOutage_mixtrsplore_qy(String outage_mixtrsplore_qy) {
		this.outage_mixtrsplore_qy = outage_mixtrsplore_qy;
	}
	public String getMesure_utnsil_nm() {
		return mesure_utnsil_nm;
	}
	public void setMesure_utnsil_nm(String mesure_utnsil_nm) {
		this.mesure_utnsil_nm = mesure_utnsil_nm;
	}
	public String getMesure_scope() {
		return mesure_scope;
	}
	public void setMesure_scope(String mesure_scope) {
		this.mesure_scope = mesure_scope;
	}
	public String getMesure_mth() {
		return mesure_mth;
	}
	public void setMesure_mth(String mesure_mth) {
		this.mesure_mth = mesure_mth;
	}
	public byte[] getMesure_atch_photo1() {
		return mesure_atch_photo1;
	}
	public void setMesure_atch_photo1(byte[] mesure_atch_photo1) {
		this.mesure_atch_photo1 = mesure_atch_photo1;
	}
	public byte[] getMesure_atch_photo2() {
		return mesure_atch_photo2;
	}
	public void setMesure_atch_photo2(byte[] mesure_atch_photo2) {
		this.mesure_atch_photo2 = mesure_atch_photo2;
	}
	public byte[] getMesure_atch_photo3() {
		return mesure_atch_photo3;
	}
	public void setMesure_atch_photo3(byte[] mesure_atch_photo3) {
		this.mesure_atch_photo3 = mesure_atch_photo3;
	}
	public byte[] getMesure_atch_photo4() {
		return mesure_atch_photo4;
	}
	public void setMesure_atch_photo4(byte[] mesure_atch_photo4) {
		this.mesure_atch_photo4 = mesure_atch_photo4;
	}
	public String getPick_lt_no() {
		return pick_lt_no;
	}
	public void setPick_lt_no(String pick_lt_no) {
		this.pick_lt_no = pick_lt_no;
	}
	public String getIncrement_no() {
		return increment_no;
	}
	public void setIncrement_no(String increment_no) {
		this.increment_no = increment_no;
	}
	public String getLt_dt() {
		return lt_dt;
	}
	public void setLt_dt(String lt_dt) {
		this.lt_dt = lt_dt;
	}
	public String getLt_pick_qy() {
		return lt_pick_qy;
	}
	public void setLt_pick_qy(String lt_pick_qy) {
		this.lt_pick_qy = lt_pick_qy;
	}
	public String getPick_mesure_no() {
		return pick_mesure_no;
	}
	public void setPick_mesure_no(String pick_mesure_no) {
		this.pick_mesure_no = pick_mesure_no;
	}
	public String getSplore_no() {
		return splore_no;
	}
	public void setSplore_no(String splore_no) {
		this.splore_no = splore_no;
	}
	public String getMesure_dm() {
		return mesure_dm;
	}
	public void setMesure_dm(String mesure_dm) {
		this.mesure_dm = mesure_dm;
	}
	public String getMesure_lt() {
		return mesure_lt;
	}
	public void setMesure_lt(String mesure_lt) {
		this.mesure_lt = mesure_lt;
	}
	public String getBio_no() {
		return bio_no;
	}
	public void setBio_no(String bio_no) {
		this.bio_no = bio_no;
	}
	public String getLt_dt_h() {
		return lt_dt_h;
	}
	public void setLt_dt_h(String lt_dt_h) {
		this.lt_dt_h = lt_dt_h;
	}
	public String getLt_dt_m() {
		return lt_dt_m;
	}
	public void setLt_dt_m(String lt_dt_m) {
		this.lt_dt_m = lt_dt_m;
	}
	public String getOutage_mixtrsplore_dth() {
		return outage_mixtrsplore_dth;
	}
	public void setOutage_mixtrsplore_dth(String outage_mixtrsplore_dth) {
		this.outage_mixtrsplore_dth = outage_mixtrsplore_dth;
	}
	public String getOutage_mixtrsplore_dtm() {
		return outage_mixtrsplore_dtm;
	}
	public void setOutage_mixtrsplore_dtm(String outage_mixtrsplore_dtm) {
		this.outage_mixtrsplore_dtm = outage_mixtrsplore_dtm;
	}
	public String getPick_place_pn() {
		return pick_place_pn;
	}
	public void setPick_place_pn(String pick_place_pn) {
		this.pick_place_pn = pick_place_pn;
	}
	public String getPick_utnsil_pn() {
		return pick_utnsil_pn;
	}
	public void setPick_utnsil_pn(String pick_utnsil_pn) {
		this.pick_utnsil_pn = pick_utnsil_pn;
	}
	public String getLt_atch_pn1() {
		return lt_atch_pn1;
	}
	public void setLt_atch_pn1(String lt_atch_pn1) {
		this.lt_atch_pn1 = lt_atch_pn1;
	}
	public String getLt_atch_pn2() {
		return lt_atch_pn2;
	}
	public void setLt_atch_pn2(String lt_atch_pn2) {
		this.lt_atch_pn2 = lt_atch_pn2;
	}
	public String getLt_atch_pn3() {
		return lt_atch_pn3;
	}
	public void setLt_atch_pn3(String lt_atch_pn3) {
		this.lt_atch_pn3 = lt_atch_pn3;
	}
	public String getLt_atch_pn4() {
		return lt_atch_pn4;
	}
	public void setLt_atch_pn4(String lt_atch_pn4) {
		this.lt_atch_pn4 = lt_atch_pn4;
	}
	public String getMesure_atch_pn1() {
		return mesure_atch_pn1;
	}
	public void setMesure_atch_pn1(String mesure_atch_pn1) {
		this.mesure_atch_pn1 = mesure_atch_pn1;
	}
	public String getMesure_atch_pn2() {
		return mesure_atch_pn2;
	}
	public void setMesure_atch_pn2(String mesure_atch_pn2) {
		this.mesure_atch_pn2 = mesure_atch_pn2;
	}
	public String getMesure_atch_pn3() {
		return mesure_atch_pn3;
	}
	public void setMesure_atch_pn3(String mesure_atch_pn3) {
		this.mesure_atch_pn3 = mesure_atch_pn3;
	}
	public String getMesure_atch_pn4() {
		return mesure_atch_pn4;
	}
	public void setMesure_atch_pn4(String mesure_atch_pn4) {
		this.mesure_atch_pn4 = mesure_atch_pn4;
	}
	public MultipartFile getPick_place_photo_img() {
		return pick_place_photo_img;
	}
	public void setPick_place_photo_img(MultipartFile pick_place_photo_img) {
		this.pick_place_photo_img = pick_place_photo_img;
	}
	public MultipartFile getPick_utnsil_photo_img() {
		return pick_utnsil_photo_img;
	}
	public void setPick_utnsil_photo_img(MultipartFile pick_utnsil_photo_img) {
		this.pick_utnsil_photo_img = pick_utnsil_photo_img;
	}
	public MultipartFile getLt_atch_photo1_img() {
		return lt_atch_photo1_img;
	}
	public void setLt_atch_photo1_img(MultipartFile lt_atch_photo1_img) {
		this.lt_atch_photo1_img = lt_atch_photo1_img;
	}
	public MultipartFile getLt_atch_photo2_img() {
		return lt_atch_photo2_img;
	}
	public void setLt_atch_photo2_img(MultipartFile lt_atch_photo2_img) {
		this.lt_atch_photo2_img = lt_atch_photo2_img;
	}
	public MultipartFile getLt_atch_photo3_img() {
		return lt_atch_photo3_img;
	}
	public void setLt_atch_photo3_img(MultipartFile lt_atch_photo3_img) {
		this.lt_atch_photo3_img = lt_atch_photo3_img;
	}
	public MultipartFile getLt_atch_photo4_img() {
		return lt_atch_photo4_img;
	}
	public void setLt_atch_photo4_img(MultipartFile lt_atch_photo4_img) {
		this.lt_atch_photo4_img = lt_atch_photo4_img;
	}
	public MultipartFile getMesure_atch_photo1_img() {
		return mesure_atch_photo1_img;
	}
	public void setMesure_atch_photo1_img(MultipartFile mesure_atch_photo1_img) {
		this.mesure_atch_photo1_img = mesure_atch_photo1_img;
	}
	public MultipartFile getMesure_atch_photo2_img() {
		return mesure_atch_photo2_img;
	}
	public void setMesure_atch_photo2_img(MultipartFile mesure_atch_photo2_img) {
		this.mesure_atch_photo2_img = mesure_atch_photo2_img;
	}
	public MultipartFile getMesure_atch_photo3_img() {
		return mesure_atch_photo3_img;
	}
	public void setMesure_atch_photo3_img(MultipartFile mesure_atch_photo3_img) {
		this.mesure_atch_photo3_img = mesure_atch_photo3_img;
	}
	public MultipartFile getMesure_atch_photo4_img() {
		return mesure_atch_photo4_img;
	}
	public void setMesure_atch_photo4_img(MultipartFile mesure_atch_photo4_img) {
		this.mesure_atch_photo4_img = mesure_atch_photo4_img;
	}
	public byte[] getDown_file_data() {
		return down_file_data;
	}
	public void setDown_file_data(byte[] down_file_data) {
		this.down_file_data = down_file_data;
	}
	public String getDown_file_nm() {
		return down_file_nm;
	}
	public void setDown_file_nm(String down_file_nm) {
		this.down_file_nm = down_file_nm;
	}
	public String getSampling_yn() {
		return sampling_yn;
	}
	public void setSampling_yn(String sampling_yn) {
		this.sampling_yn = sampling_yn;
	}
	public String getSolid_gbn() {
		return solid_gbn;
	}
	public void setSolid_gbn(String solid_gbn) {
		this.solid_gbn = solid_gbn;
	}
	public String getRawmtrl_gbn() {
		return rawmtrl_gbn;
	}
	public void setRawmtrl_gbn(String rawmtrl_gbn) {
		this.rawmtrl_gbn = rawmtrl_gbn;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getVrticl() {
		return vrticl;
	}
	public void setVrticl(String vrticl) {
		this.vrticl = vrticl;
	}
	public String getSungsang1() {
		return sungsang1;
	}
	public void setSungsang1(String sungsang1) {
		this.sungsang1 = sungsang1;
	}
	public String getSungsang2() {
		return sungsang2;
	}
	public void setSungsang2(String sungsang2) {
		this.sungsang2 = sungsang2;
	}
	public String getSungsang3() {
		return sungsang3;
	}
	public void setSungsang3(String sungsang3) {
		this.sungsang3 = sungsang3;
	}
	public String getSungsang4() {
		return sungsang4;
	}
	public void setSungsang4(String sungsang4) {
		this.sungsang4 = sungsang4;
	}
	public String getSungsang5() {
		return sungsang5;
	}
	public void setSungsang5(String sungsang5) {
		this.sungsang5 = sungsang5;
	}
	public String getSungsang6() {
		return sungsang6;
	}
	public void setSungsang6(String sungsang6) {
		this.sungsang6 = sungsang6;
	}
	public String getPick_time() {
		return pick_time;
	}
	public void setPick_time(String pick_time) {
		this.pick_time = pick_time;
	}
	public String getPick_utnsil_unit() {
		return pick_utnsil_unit;
	}
	public void setPick_utnsil_unit(String pick_utnsil_unit) {
		this.pick_utnsil_unit = pick_utnsil_unit;
	}
	public String getPick_place_method() {
		return pick_place_method;
	}
	public void setPick_place_method(String pick_place_method) {
		this.pick_place_method = pick_place_method;
	}
	public String getSungsang0() {
		return sungsang0;
	}
	public void setSungsang0(String sungsang0) {
		this.sungsang0 = sungsang0;
	}
	public String getSungsang_etc() {
		return sungsang_etc;
	}
	public void setSungsang_etc(String sungsang_etc) {
		this.sungsang_etc = sungsang_etc;
	}
	
}
