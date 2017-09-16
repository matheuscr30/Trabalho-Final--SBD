package agenciabancaria.Models;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/**
 *
 * @author matheus
 */
public class Emprestimo {
    private int id_emprestimo;
    private float valor;
    private int quantparcelas;
    private String agencia_nome;

    public Emprestimo() {
    }
    
    public int getId_emprestimo() {
        return id_emprestimo;
    }

    public void setId_emprestimo(int id_emprestimo) {
        this.id_emprestimo = id_emprestimo;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public int getQuantparcelas() {
        return quantparcelas;
    }

    public void setQuantparcelas(int quantparcelas) {
        this.quantparcelas = quantparcelas;
    }

    public String getAgencia_nome() {
        return agencia_nome;
    }

    public void setAgencia_nome(String agencia_nome) {
        this.agencia_nome = agencia_nome;
    }
    
    
}
