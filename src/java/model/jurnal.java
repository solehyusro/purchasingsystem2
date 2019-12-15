/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author USER PC
 */
public class jurnal {
    private String no_jurnal;
    private String kd_admin;
    private String d_akun;
    private String k_akun;
    private String ket;
    private String tgl;
    private String no_po;
    private double debet;
    private double kredit;

    public String getNo_jurnal() {
        return no_jurnal;
    }

    public void setNo_jurnal(String no_jurnal) {
        this.no_jurnal = no_jurnal;
    }

    public String getKd_admin() {
        return kd_admin;
    }

    public void setKd_admin(String kd_admin) {
        this.kd_admin = kd_admin;
    }

    public String getD_akun() {
        return d_akun;
    }

    public void setD_akun(String d_akun) {
        this.d_akun = d_akun;
    }

    public String getK_akun() {
        return k_akun;
    }

    public void setK_akun(String k_akun) {
        this.k_akun = k_akun;
    }

    public String getKet() {
        return ket;
    }

    public void setKet(String ket) {
        this.ket = ket;
    }

    public String getTgl() {
        return tgl;
    }

    public void setTgl(String tgl) {
        this.tgl = tgl;
    }

    public String getNo_po() {
        return no_po;
    }

    public void setNo_po(String no_po) {
        this.no_po = no_po;
    }

    public double getDebet() {
        return debet;
    }

    public void setDebet(double debet) {
        this.debet = debet;
    }

    public double getKredit() {
        return kredit;
    }

    public void setKredit(double kredit) {
        this.kredit = kredit;
    }
    
}
